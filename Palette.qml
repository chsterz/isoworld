import QtQuick 2.7
import QtQuick.Window 2.2

Rectangle {
    id: palette
    anchors.top: parent.top
    anchors.topMargin: 4
    anchors.right: parent.right
    anchors.rightMargin: 4
    width: 112
    height: 40
    color: "#ff555753"
    
    property string pickedColor: "#055fcf"
    property var colors: ["#055fcf", "#bfff00", "#f40039"]
    
    Row{
        anchors.centerIn: parent
        spacing: 4
    Repeater{
        model: colors
        delegate: Rectangle{
            width: 32
            height: 32
            color: modelData

            border.width: 2
            border.color: (color == palette.pickedColor) ? Qt.lighter(color) : palette.color

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    palette.pickedColor = parent.color
                }
            }
        }
    } }
}
