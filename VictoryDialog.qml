import QtQuick.Dialogs 1.2

MessageDialog {
    signal dialogAccepted()

    title: "Victory!"
    text: "Congratulations! You won! Start a new game?"

    onAccepted: {
        dialogAccepted();
        destroy();
    }
}
