import QtQuick 2.7
import QtQuick.Window 2.2

Window {
    id: root
    visible: true
    width: 640
    height: 480
    title: qsTr("Iso-World")
    Image{
        id: background
        anchors.fill: parent
        source: "img/img/background.png"
    }

    IsoWorld {
        id: isoWorld
        x: 334
        y: 40
    }
}
