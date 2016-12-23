import QtQuick 2.7
import QtQuick.Window 2.2

Window {
    id: root
    visible: true
    width: 1024
    height: 768
    title: qsTr("Iso-World")

    Image{
        id: background
        anchors.fill: parent
        source: "img/img/background.png"
    }

    IsoWorld {
        id: isoWorld
        cubeColor: palette.pickedColor
    }

    Palette {
        id: palette
    }
}
