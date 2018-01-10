import QtQuick.Controls 1.4

Menu {
    id: _contextMenu

    signal itemClicked()

    MenuItem {
        text: "Start new game"

        onTriggered: {
            itemClicked();
        }
    }
}
