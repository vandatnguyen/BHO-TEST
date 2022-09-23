import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';

import 'html_parser_utils.dart';
import 'html_parser_extension.dart';
import 'html_parser_shared.dart';
import 'html_parser_helper.dart';

import 'package:flutter/services.dart' show rootBundle;

String test = "";

class HtmlParser {
  List<HtmlParserElement> _elements = [];
  List<HtmlParserElement> elements = [];
  Future<Null>? isWorking;
  
  Future<String> loadTestText() async {
    return await rootBundle.loadString("assets/images/test.html");
  }

  HtmlParser() {}

void printWrapped(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}
  String normalHtml(String html){
    String normal = html.replaceAll("\n","")
    .replaceAll(RegExp(r"\s{2,}")," ")
    .replaceAll(RegExp(r"\t{2,}")," "); 
    return normal;
  }
  Future<List<HtmlParserElement>> parserHtml(String content) async {
    if (isWorking != null) {
      await isWorking;
      return elements;
    }
    var completer = Completer<Null>();
    isWorking = completer.future;
    _elements.clear();
    elements.clear();
    
   // String content = await loadTestText();
    final DOMParser = HtmlParserHelper("<div>${normalHtml(content)}</div>");
    parseContentElement(DOMParser.children.first);
    elements = mergeHtmlTag(_elements); 
    completer.complete();
    isWorking = null;
    return elements;
  }

  void parseContentElement(Node node,
      {HtmlParserElementTextStyle parentStyle =
          HtmlParserElementTextStyle.normal,
      String? overrideTagName}) {
    var element = node.asOrNull<Element>();
    final tagName = element?.localName ?? "text";
    final resultTagName = overrideTagName ?? tagName;
    final childNodes = node.nodes;
    var hasAdded = false;

    var addElement = (HtmlParserElement element) {
      hasAdded = true;
      _elements.add(element);
    };

    final newStyle =
        mergeStyle(parentStyle, HtmlParserUtils().tagToStyle(tagName));
    //print("-> $newStyle $parentStyle");

    if (HtmlParserUtils().isRemoveComponent(node)) {
      return ;
    }
    else if (!HtmlParserUtils().isSupportTag(tagName) || HtmlParserUtils().isCustomRenderNode(node)  ) {
      final parseNode = parseCustomNode(node);
     // print("custom node");
      addElement(parseNode);
      return;
    } else if (HtmlParserUtils().isTextTag(tagName)) {
      if (HtmlParserUtils().isTextNode(node) && childNodes.isEmpty) {
        final parseNode = parseTextNode(node, parentStyle: parentStyle);
        var nodeContent = parseNode.content;
        parseNode.tagName = resultTagName;
        if (nodeContent != null && (nodeContent as String).trim().isNotEmpty == true) {
          addElement(parseNode);
        }
      } else if (childNodes.length == 1) {
        parseContentElement(childNodes[0],
            parentStyle: newStyle, overrideTagName: resultTagName);
        return;
      }
    } else if (HtmlParserUtils().isImageTag(tagName)) {
      final parseNode = parseImageNode(node);
      addElement(parseNode);
    } else if (HtmlParserUtils().isHyperLinkTag(tagName)) {
      final parseNode = parseTextNode(node, parentStyle: parentStyle);
      var nodeContent = parseNode.content; 
      if (nodeContent != null && (nodeContent as String).isNotEmpty == true) {
        parseNode.attachmentLink = node.attributes["href"];
        addElement(parseNode);
      } 
      return ;
    } else if (HtmlParserUtils().isVideoTag(tagName)) {
      final parseNode = parseVideoNode(node);
      addElement(parseNode);
    } else if (HtmlParserUtils().isWebViewTag(tagName)) {
      final parseNode = parseWebViewTag(node);
      addElement(parseNode);
    } else if (HtmlParserUtils().isTableTag(tagName)) {
      final parseNode = parseTableNode(node);
      addElement(parseNode);
    } else if (HtmlParserUtils().isBreakLineTag(tagName)) {
      final parseNode = HtmlParserElement(
          className: null,
          tagName: "br",
          style: newStyle,
          type: HtmlParserElementType.breakline);
      addElement(parseNode);
    } else if (HtmlParserUtils().isSkipTag(tagName)) {
      return;
    }

    // parse child
    if (childNodes.length > 1 ||
        (!HtmlParserUtils().isTextTag(tagName) && childNodes.length > 0)) {
      for (var child in childNodes) {
        // print("$tagName $newStyle");
        parseContentElement(child, parentStyle: newStyle);
      }
    }
    // add breack line
    if (hasAdded && HtmlParserUtils().isBlockTag(resultTagName)) {
      _elements.add(HtmlParserElement(
          type: HtmlParserElementType.breakline,
          tagName: "p",
          style: HtmlParserElementTextStyle.normal));
    }
  }

  HtmlParserElement parseTextNode(Node node,
      {required HtmlParserElementTextStyle parentStyle}) {
    var element = node.asOrNull<Element>();
    var tagName = element?.localName ?? "text";
    var className = element?.classes.map((e) => e).toList();

    if (element == null && node.parent != null) {
      className = node.parent?.classes.map((e) => e).toList();
    }

    if (className?.isEmpty == true) {
      className = null;
    }
    var newStyle =
        mergeStyle(parentStyle, HtmlParserUtils().tagToStyle(tagName));

    var text = node.text;
 
    //print("--> $newStyle $parentStyle");

    return HtmlParserElement(
        className: className,
        tagName: tagName,
        style: newStyle,
        content: text?.replaceAll("\n", "").replaceAll("\r", ""),
        type: HtmlParserElementType.text);
  }

  HtmlParserElement parseImageNode(Node node) {
    final element = node.asOrNull<Element>();
    final imageSrc = node.attributes["src"];
    final alt = node.attributes["alt"];
 

    var parserElement = HtmlParserElement(
        tagName: element?.localName ?? "img",
        content: {"alt": alt, "src": imageSrc},
        type: HtmlParserElementType.image);

    return parserElement;
  }

  HtmlParserElement parseVideoNode(Node node) {
    final element = node.asOrNull<Element>();
    final tagName = element?.localName ?? "video";
    // Todo - part url video
    final videoSrc =
        node.attributes["db24h_src"] ?? node.attributes["db24h_src"];
    final posterUrl = node.attributes["poster"];

    var parserElement = HtmlParserElement(
        tagName: tagName,
        content: {
          "posterUrl": posterUrl,
          "src": videoSrc,
        },
        type: HtmlParserElementType.video);

    return parserElement;
  }

  HtmlParserElement parseTableNode(Node node) {
    final element = node.asOrNull<Element>();
    final tagName = element?.localName ?? "table";

    var parserElement = HtmlParserElement(
        tagName: tagName,
        content: element?.outerHtml,
        type: HtmlParserElementType.table);

    return parserElement;
  }

  HtmlParserElement parseCustomNode(Node node) {
    final element = node.asOrNull<Element>();
    final tagName = element?.localName ?? "div";

    var parserElement = HtmlParserElement(
        tagName: tagName,
        content: element?.outerHtml,
        type: HtmlParserElementType.custom);

    return parserElement;
  }

  HtmlParserElement parseWebViewTag(Node node) {
    final element = node.asOrNull<Element>();
    final tagName = element?.localName ?? "div";
    final src = node.attributes["src"];
    var parserElement = HtmlParserElement(
        tagName: tagName,
        content: {"src": src},
        type: HtmlParserElementType.webview);

    return parserElement;
  }

  HtmlParserElementTextStyle mergeStyle(HtmlParserElementTextStyle parentStyle,
      HtmlParserElementTextStyle newStyle) {
    if (parentStyle == newStyle) {
      return newStyle;
    }
    if (parentStyle == HtmlParserElementTextStyle.normal) {
      return newStyle;
    }
    if ((parentStyle == HtmlParserElementTextStyle.bold &&
            newStyle == HtmlParserElementTextStyle.italic) ||
        (newStyle == HtmlParserElementTextStyle.bold &&
            parentStyle == HtmlParserElementTextStyle.italic)) {
      return HtmlParserElementTextStyle.boldItalic;
    }

    if (newStyle == HtmlParserElementTextStyle.boldItalic ||
        parentStyle == HtmlParserElementTextStyle.boldItalic) {
      return HtmlParserElementTextStyle.boldItalic;
    }

    return HtmlParserElementTextStyle
        .values[max(newStyle.index, parentStyle.index)];
  }

  HtmlParserElement? checkGroupTag(HtmlParserElement element) {
    if (element.children == null) {
      return null;
    }

    if (element.children!.length == 1) {
      final first = element.children![0];
      if (first.type == HtmlParserElementType.text) {
        first.content = (first.content ?? "").trim();
      }
      return first;
    }
    final children = element.children ?? [];

    HtmlParserElementTextStyle? elementStyle;
    var isSingleStyle = true;

    for (var child in children) {
      if ((elementStyle != null && elementStyle != child.style) ||
          child.attachmentLink != null) {
        isSingleStyle = false;
        break;
      }
      elementStyle = child.style;
    }

    if (!isSingleStyle) {
      return element;
    }

    final text = children.map((e) => e.toText()).reduce((prev, current) {
      return prev + current;
    });
    // tạo thẻ mới gộp
    return HtmlParserElement(
      type: HtmlParserElementType.text,
      tagName: "text",
      style: HtmlParserElementTextStyle.normal,
      content: text.trim(),
    );
  }

  List<HtmlParserElement> mergeHtmlTag(List<HtmlParserElement> input) {
    List<HtmlParserElement> result = [];
    HtmlParserElement? newsItem;
    var isBrAppendLast = false;

    for (var element in input) {
      final isMediaTag = HtmlParserUtils().isImageTag(element.tagName) ||
          HtmlParserUtils().isImageTag(element.tagName);

      final isBreakLine = HtmlParserUtils().isBreakLineTag(element.tagName);
      final isBlock = HtmlParserUtils().isBlockTag(element.tagName) ||
          element.type == HtmlParserElementType.custom;
      // tạo thành element khi gặp thẻ đóng
      if (newsItem != null && (isMediaTag || isBreakLine || isBlock)) {
        final groupItem = checkGroupTag(newsItem);
        if (groupItem != null) {
          result.add(groupItem);
          isBrAppendLast = false;
        }

        // chỉ đưa vào các thẻ có dữ liệu và không phải là dữ liệu xuống dòng
        // ngoại trừ thẻ xuống dòng

        if (!(element.content == null && element.content == "") ||
            isBreakLine) {
          var canAppend = true;
          // check append breakline
          if (isBreakLine && !isBrAppendLast) {
            canAppend = false;
          }
          if (!isBreakLine && element.type == HtmlParserElementType.breakline) {
            canAppend = false;
          }
          isBrAppendLast = isBreakLine;
          if (canAppend) {
            result.add(element);
          }
        }
        newsItem = null;
        continue;
      }
      if (newsItem == null && isBlock) {
        if (element.type == HtmlParserElementType.breakline) {
          if (element.tagName == "p") {
            continue;
          } else if (element.tagName == "br") {
            if (!isBrAppendLast) {
              isBrAppendLast = true;
              continue;
            }
          }
        }
        result.add(element);
      } else if (!(element.content == null || element.content == "")) {
        newsItem ??= HtmlParserElement(
          type: HtmlParserElementType.group,
          tagName: "group",
          style: HtmlParserElementTextStyle.normal,
          content: null,
          children: [],
        );

        newsItem.children!.add(element);
      }
      isBrAppendLast = isBreakLine;
    }

    if (newsItem != null) {
      final groupItem = checkGroupTag(newsItem);
      if (groupItem != null) {
        result.add(groupItem);
      }
    }
    return result;
  }
}
