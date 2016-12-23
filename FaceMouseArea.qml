import QtQuick 2.7
import QtQuick.Window 2.2

MouseArea{
    property var creationOffset: Qt.vector3d(0, 0, 1)

    anchors.fill: parent
    acceptedButtons: Qt.AllButtons
    onWheel: {parent.parent.color = Qt.hsla(Math.random(),0.8,0.5,1)}
    onClicked: {
        if (mouse.button & Qt.LeftButton) {
            isoCube.parent.createCubeAt(isoCube.xpos + creationOffset.x, isoCube.ypos + creationOffset.y, creationOffset.z);
        } else {
            isoCube.destroy()
        }
    }
}
