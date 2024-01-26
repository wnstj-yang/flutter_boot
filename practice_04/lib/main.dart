import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TextFieldWidget(),
    );
  }
}

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({super.key});

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  TextEditingController leftController = TextEditingController(text: 'Hello');
  TextEditingController rightController =
      TextEditingController(text: 'FlutterBoot!');
  FocusNode leftFocusNode = FocusNode();
  FocusNode rightFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Hello TextField!",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 32,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Focus(
                  onKey: (node, event) {
                    // 왼쪽 TextField가 비어있고 backspace이며 키를 누른이후
                    if (event.logicalKey.keyLabel == 'Backspace' &&
                        leftController.value.text.isEmpty &&
                        event.runtimeType == RawKeyDownEvent) {
                      rightFocusNode.requestFocus(); // 오른쪽 TextField에 focus
                      return KeyEventResult.handled;
                      // 탭으로 누른 이후 오른쪽 TextField에 focus
                    } else if (event.logicalKey.keyLabel == 'Tab' &&
                        event.runtimeType == RawKeyDownEvent) {
                      rightFocusNode.requestFocus();
                      return KeyEventResult.handled;
                      // 이외의 경우에는 상관 X
                    } else {
                      return KeyEventResult.ignored;
                    }
                  },
                  // 각 TextField에 controller와 focusNode를 각각 등록
                  child: TextField(
                    autofocus: true,
                    controller: leftController,
                    focusNode: leftFocusNode,
                    onSubmitted: (_) {
                      rightFocusNode
                          .requestFocus(); // 제출(엔터)했을 시 오른쪽 TextField에 focus
                    },
                    onChanged: (value) {
                      // 현재 TextField이 비어있지 않지만 바뀌는 상태(해당 화면은 backspace 뿐)임과 동시에
                      // 커서의 위치가 0일 때 커서를 끝으로 옮겨줘서 지울수 있게 만들어준다.
                      if (value.isNotEmpty &&
                          leftController.selection.base.offset == 0) {
                        leftController.selection = TextSelection.collapsed(
                            offset: leftController.value.text.length);
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(
                width: 50,
              ),
              // 상단의 Focus 위젯 내 TextField와 로직은 동일하며 controller, focusNode만 다름
              Expanded(
                child: Focus(
                  onKey: (node, event) {
                    if (event.runtimeType == RawKeyDownEvent &&
                        (event.logicalKey.keyLabel == 'Backspace' &&
                            rightController.value.text.isEmpty)) {
                      leftFocusNode.requestFocus();
                      return KeyEventResult.handled;
                    } else if (event.logicalKey.keyLabel == 'Tab' &&
                        event.runtimeType == RawKeyDownEvent) {
                      leftFocusNode.requestFocus();
                      return KeyEventResult.handled;
                    } else {
                      return KeyEventResult.ignored;
                    }
                  },
                  child: TextField(
                    autofocus: true,
                    controller: rightController,
                    focusNode: rightFocusNode,
                    onSubmitted: (_) {
                      leftFocusNode.requestFocus();
                    },
                    onChanged: (value) {
                      if (value.isNotEmpty &&
                          rightController.selection.base.offset == 0) {
                        rightController.selection = TextSelection.collapsed(
                            offset: rightController.value.text.length);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
