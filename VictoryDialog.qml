import QtQuick.Dialogs 1.2

MessageDialog {
    id: _victoryDialog

    signal dialogAccepted()

    title: "Victory!"
    text: "Congratulations! You won! Start a new game?"

    onAccepted: {
        dialogAccepted();
    }
}
