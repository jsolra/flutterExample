import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

// void main() => runApp(MaterialApp(home: DemoApp()));

class DemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Read More Text',
      )),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: CustomPaint(
                size: Size(double.infinity, 300),
                painter: MyTextPainter(
                  text: TextSpan(
                    text:
                        'TextPainter당신이 오른쪽에 텍스트를 그릴 수 있습니다 Canvas, 그것은이를 제공 Canvas하고 Size의 paint()방법. 또한, TextPainter이 ellipsis당신이 자른 텍스트 끝에 대체됩니다 문자열을 대체 할 수 있습니다 속성을. TextPainter줄임표를 설정하고 최대 줄 수를 정의 할 수 있습니다. 하지만 CustomPaint렌더링 해야 합니다. 그리고 CustomPaint와 쌍으로 작동 CustomPainter하므로 TextPainter내부 를 래핑해야합니다 CustomPainter. 또한 선의 끝이 어디인지 textDirection알려주도록 설정해야합니다 TextPainter.',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                  ellipsis: "... 더보기",
                  maxLines: 4,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ExpandableText(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque scelerisque efficitur posuere. Curabitur tincidunt placerat diam ac efficitur. Cras rutrum egestas nisl vitae pulvinar. Donec id mollis diam, id hendrerit neque. Donec accumsan efficitur libero, vitae feugiat odio fringilla ac. Aliquam a turpis bibendum, varius erat dictum, feugiat libero. Nam et dignissim nibh. Morbi elementum varius elit, at dignissim ex accumsan a',
                trimLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyTextPainter extends CustomPainter {
  final TextSpan text;
  final int maxLines;
  final String ellipsis;

  MyTextPainter(
      {required this.text, required this.ellipsis, required this.maxLines})
      : super();

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;

  @override
  void paint(Canvas canvas, Size size) {
    TextPainter painter = TextPainter(
      text: text,
      maxLines: maxLines,
      textDirection: TextDirection.ltr,
    )..ellipsis = this.ellipsis;
    painter.layout(maxWidth: size.width);
    painter.paint(canvas, Offset(0, 0));
  }
}

// class HomePage extends StatelessWidget {
//   HomePage({Key? key}) : super(key: key);

//   var someVeryLongText = // Some realy long text

//   @override
//   Widget build(BuildContext context) => Scaffold(
//         body: SafeArea(
//           child: Container(
//             child: CustomPaint(
//               size: Size(double.infinity, 300),
//               painter: MyTextPainter(
//                 text: TextSpan(text: someVeryLongText,       style: TextStyle(
//         color: Colors.grey,
//         fontWeight: FontWeight.bold,
//         fontSize: 10,
//       ),),
//                 ellipsis: "... 더보기",
//                 maxLines: 4,
//               ),
//             ),
//           ),
//         ),
//       );
// }

class ExpandableText extends StatefulWidget {
  const ExpandableText(
    this.text, {
    Key? key,
    this.trimLines = 2,
  })  : assert(text != null),
        super(key: key);

  final String text;
  final int trimLines;

  @override
  ExpandableTextState createState() => ExpandableTextState();
}

class ExpandableTextState extends State<ExpandableText> {
  bool _readMore = true;
  // void _onTapLink() {
  //   setState(() => _readMore = !_readMore);
  // }

  @override
  Widget build(BuildContext context) {
    final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);
    final colorClickableText = Colors.blue;
    final widgetColor = Colors.black;
    TextSpan link = TextSpan(
      text: _readMore ? "... 더보기" : " 최소화",
      style: TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.bold,
        fontSize: 10,
      ),
      recognizer: TapGestureRecognizer()
        ..onTap = () {
          print('touch');
        },
    );
    Widget result = LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        assert(constraints.hasBoundedWidth);
        final double maxWidth = constraints.maxWidth;
        // Create a TextSpan with data
        final text = TextSpan(
          text: widget.text,
        );
        // Layout and measure link
        TextPainter textPainter = TextPainter(
          text: link,
          textDirection: TextDirection
              .rtl, //better to pass this from master widget if ltr and rtl both supported
          maxLines: widget.trimLines,
          ellipsis: '...',
        );
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final linkSize = textPainter.size;
        // Layout and measure text
        textPainter.text = text;
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final textSize = textPainter.size;
        // Get the endIndex of data
        int endIndex;
        final pos = textPainter.getPositionForOffset(Offset(
          textSize.width - linkSize.width,
          textSize.height,
        ));
        endIndex = textPainter.getOffsetBefore(pos.offset)!;
        var textSpan;
        if (textPainter.didExceedMaxLines) {
          textSpan = TextSpan(
            text: _readMore ? widget.text.substring(0, endIndex) : widget.text,
            style: TextStyle(
              color: widgetColor,
            ),
            children: <TextSpan>[link],
          );
        } else {
          textSpan = TextSpan(
            text: widget.text,
          );
        }
        return RichText(
          softWrap: true,
          overflow: TextOverflow.clip,
          text: textSpan,
        );
      },
    );
    return result;
  }
}
