export 'package:html/dom.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';

class HtmlParserHelper {
  late DocumentFragment doc;

  List<Element> get children => doc.children;
  List<Node> get nodes => doc.nodes;

  HtmlParserHelper(String content) {
    doc = parseFragment(content);
  }
}
