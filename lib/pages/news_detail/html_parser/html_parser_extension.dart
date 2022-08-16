import 'html_parser_utils.dart';
import 'html_parser_shared.dart';

extension AsExtension on Object? {
  X as<X>() => this as X;
  X? asOrNull<X>() {
    var self = this;
    return self is X ? self : null;
  }
}

extension AsSubtypeExtension<X> on X {
  Y asSubtype<Y extends X>() => this as Y;
}

extension AsNotNullExtension<X> on X? {
  X asNotNull() => this as X;
}

extension TagToStyleExtension on HtmlParserUtils {
  HtmlParserElementTextStyle tagToStyle(String tag) {
    if (boldTags.contains(tag)) {
      return HtmlParserElementTextStyle.bold;
    }
    if (tag == "i" || tag == "em") {
      return HtmlParserElementTextStyle.italic;
    }
    if (tag == "dd") {
      return HtmlParserElementTextStyle.italic;
    }
    if (noticTags.contains(tag)) {
      return HtmlParserElementTextStyle.note;
    }
    if (tag == "tn") {
      return HtmlParserElementTextStyle.note;
    }
    return HtmlParserElementTextStyle.normal;
  }
}
