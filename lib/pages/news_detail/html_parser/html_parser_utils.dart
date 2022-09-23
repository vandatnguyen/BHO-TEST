 
import 'html_parser_extension.dart';
import 'html_parser_helper.dart';

class HtmlParserUtils {
  static final HtmlParserUtils _singleton = HtmlParserUtils._internal();

  factory HtmlParserUtils() {
    return _singleton;
  }
  HtmlParserUtils._internal();

  var textTags = [
    "text",
    "div",
    "h4",
    "h3",
    "h2",
    "h6",
    "h5",
    "h1",
    "p",
    "tn",
    "strong",
    "em",
    "tn",
    "i",
    "b",
    "dd",
    "dt",
    "h1",
    "h2",
    "h3",
    "h4",
    "h5",
    "span",
    "ol",
    "sup",
    "sub",
    "abbr",
  ];
  var skipTags = ["td", "tr", "tbody", "thead"];
  var boldTags = ["h1", "h2", "h3", "h4", "h5", "b", "strong"];
  var noticTags = ["em"];
  var blockTags = [
    "div",
    "dd",
    "dt",
    "p",
    "h1",
    "h2",
    "h3",
    "h4",
    "h5",
    "ol",
    "h6",
    "figure",
    "group",
    "video",
    "img",
    "iframe",
    "br",
  ];
  var webviewTags = ["iframe"];

  bool isTextTag(String tag) {
    return tag == "text" || textTags.contains(tag);
  }

  bool isVideoTag(String tag) {
    return tag == "video";
  }

  bool isImageTag(String tag) {
    return tag == "img";
  }

  bool isBlockTag(String tag) {
    return blockTags.contains(tag);
  }

  bool isBreakLineTag(String tag) {
    return tag == "br";
  }

  bool isHyperLinkTag(String tag) {
    return tag == "a";
  }

  bool isSkipTag(String tag) {
    return skipTags.contains(tag);
  }

  bool isWebViewTag(String tag) {
    return webviewTags.contains(tag);
  }

  bool isTableTag(String tag) {
    return false; //tag == "table";
  }

  bool isTextNode(Node node) {
    if (node == null) {
      return true;
    }
    if (node is Element) {
      return false;
    }
    return node.children.isEmpty;
  }

  bool isCustomRenderNode(Node node) {

    var element = node.asOrNull<Element>(); 
    var className = element?.classes.map((e) => e).toList();
    if (element == null && node.parent != null) {
      className = node.parent?.classes.map((e) => e).toList();
    }
    if ( (className?.indexOf("coinr4-display-for-mobile") ?? -1) >= 0 ) {
      return true;
    }
    return false;
  }


  bool isRemoveComponent (Node node) {
   var element = node.asOrNull<Element>(); 
    var className = element?.classes.map((e) => e).toList();
    if (element == null && node.parent != null) {
      className = node.parent?.classes.map((e) => e).toList();
    }
    if ( (className?.indexOf("coinr4-display-for-mobile") ?? -1) < 0 && (className?.indexOf("coinr4-display-for-web") ?? -1) >= 0  ) {
      return true;
    }
    return false; 
}


  bool isSupportTag(String tag) {
    return isBlockTag(tag) || isTextTag(tag) || isHyperLinkTag(tag);
  }
}
