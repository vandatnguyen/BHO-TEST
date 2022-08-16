enum HtmlParserElementTextStyle { normal, bold, italic, note, boldItalic }

enum HtmlParserElementType {
  text,
  image,
  video,
  table,
  group,
  breakline,
  webview,
  custom
}

class HtmlParserElement {
  String tagName;
  HtmlParserElementTextStyle? style;
  dynamic content;
  HtmlParserElementType type;
  String? attachmentLink;
  List<HtmlParserElement>? children;
  List<String>? className;

  HtmlParserElement(
      {required this.tagName,
      this.style,
      this.content,
      required this.type,
      this.attachmentLink,
      this.children,
      this.className});

  @override
  String toString() {
    return "$tagName ($content): children (${children == null ? 0 : children?.length})";
  }

  String toText() {
    if (content is String) {
      return content;
    }
    return content.toString();
  }
}
