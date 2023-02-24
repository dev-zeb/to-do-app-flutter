import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  final String dialogTitle, dialogDescription;
  final String yesButtonText, noButtonText;
  final void Function() yesButtonFunction, noButtonFunction;

  const ConfirmationDialog({Key? key, required this.dialogTitle,  required this.dialogDescription,  required this.yesButtonText, required this.yesButtonFunction, required this.noButtonText, required this.noButtonFunction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Dialog(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          child: Container(
            height: 240,
            width: 312,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 24,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                      ),
                      child: Text(
                        dialogTitle,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          height: 1.6,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                      ),
                      child: Text(
                        dialogDescription,
                        style: const TextStyle(
                          color: Color(0xFF757575),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 1.7,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    )
                  ],
                ),
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Colors.black,
                        width: 0.05,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: noButtonFunction,
                            splashColor: Colors.blue.withOpacity(0.45),
                            child: Ink(
                              padding: const EdgeInsets.only(
                                top: 20.0,
                                bottom: 20.0,
                              ),
                              child: Text(
                                noButtonText,
                                style: const TextStyle(
                                  color: Color(0xFF757575),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.black.withOpacity(0.25),
                        height: 32,
                        width: 0.25,
                      ),
                      Expanded(
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: yesButtonFunction,
                            splashColor: Colors.blue.withOpacity(0.45),
                            child: Ink(
                              padding: const EdgeInsets.only(
                                top: 20.0,
                                bottom: 20.0,
                              ),
                              child: Text(
                                yesButtonText,
                                style: const TextStyle(
                                  color: Colors.deepOrange,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
