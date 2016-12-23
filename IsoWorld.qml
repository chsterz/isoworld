import QtQuick 2.7
import QtQuick.Window 2.2

Rectangle {
    id: isoWorld


    width: 32*20
    height: 32*20

    x: parent.width/2

    color: "#babdb6"
    antialiasing: true

    property var component;
    property var currentCube;
    property string cubeColor;

    //The ISO perspective transform:
    transform: Matrix4x4 {
        id: isometric_perspective
        property real rotationZ: 45/360 * Math.PI * 2
        property matrix4x4 flipMatrix:
            Qt.matrix4x4(1,  0, 0, 0,
                         0, -1, 0, 0,
                         0,  0, 1, 0,
                         0,  0, 0, 1)
        property matrix4x4 rotationZMatrix:
            Qt.matrix4x4(Math.cos(rotationZ), -Math.sin(rotationZ), 0, 0,
                         Math.sin(rotationZ),  Math.cos(rotationZ), 0, 0,
                         0, 0, 1, 0,
                         0, 0, 0, 1)
        property real flatness: 0.5
        property matrix4x4 scaleYMatrix:
            Qt.matrix4x4(1,   0, 0, 0,
                         0, flatness, 0, 0,
                         0,   0, 1, 0,
                         0,   0, 0, 1)
        matrix: flipMatrix.times(scaleYMatrix).times(rotationZMatrix)
    }

    //Hovering Animation
    SequentialAnimation {
        id: hoveringAnimation

        NumberAnimation {
            duration: 4000
            target: isoWorld
            property: "y"
            from: root.height*0.95
            to: root.height*0.9
            easing.type: Easing.InOutSine
        }
        NumberAnimation {
            duration: 4000
            target: isoWorld
            property: "y"
            from: root.height*0.9
            to: root.height*0.95
            easing.type: Easing.InOutSine
        }
        loops: Animation.Infinite
        running: true
    }

    //Cube Creation Functions
    function createCubeAt(xpos, ypos, level) {
        component = Qt.createComponent("IsoCube.qml");
        if (component.status === Component.Ready)
            finishCube(xpos, ypos, level);
        else
            component.statusChanged.connect(finishCube(xpos, ypos, level));
    }

    function finishCube(xpos, ypos, level) {
        if (component.status === Component.Ready) {
            currentCube = component.createObject(isoWorld, {"xpos": xpos, "ypos": ypos, "level": level, "color": cubeColor});
            if (currentCube === null) {
                console.log("Error creating Cube!");
            }
        } else if (component.status == Component.Error) {
            // Error Handling
            console.log("Error loading component:", component.errorString());
        }
    }

    //Floor Selection Cursor
    Rectangle {
        id: selection

        width: 32
        height: 32

        visible: false
        x: 32 * xpos
        y: 32 * ypos


        property int xpos: 0
        property int ypos: 0

        antialiasing: true
        color: "#44fcaf3e"

        border.width: 2
        border.color: "#fff57900"
    }

    //Floor Mouse Area
    MouseArea {
        id: floorMouseArea

        anchors.fill: parent
        hoverEnabled: true

        onContainsMouseChanged: {
            selection.visible = containsMouse
        }

        onPositionChanged: {
            selection.xpos = mouse.x / 32
            selection.ypos = mouse.y / 32
        }

        onClicked: {
            createCubeAt(mouse.x / 32, mouse.y / 32, 0)
        }
    }
}
