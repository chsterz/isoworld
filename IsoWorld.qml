import QtQuick 2.7
import QtQuick.Window 2.2

Rectangle{
    id: isoWorld
    
    x: parent.width/2
    
    color: "#babdb6"
    width: 32*13
    height: 32*13

    property var component;
    property var currentCube;
    
    property alias transformMatrix: isometric_perspective.matrix

    function createCubeAt(xpos,ypos,level) {
        component = Qt.createComponent("IsoCube.qml");
        if (component.status == Component.Ready)
            finishCube(xpos, ypos, level);
        else
            component.statusChanged.connect(finishCube(xpos, ypos, level));
    }

    function finishCube(xpos, ypos, level) {
        if (component.status == Component.Ready) {
            console.log("Creating Cube at ",xpos, ypos, level)
            currentCube = component.createObject(isoWorld, {"xpos": xpos, "ypos": ypos, "level": level});
            if (currentCube == null) {
                console.log("Error creating cube");
            }
        } else if (component.status == Component.Error) {
            // Error Handling
            console.log("Error loading component:", component.errorString());
        }
    }

    Component.onCompleted: {
        createCubeAt(6,6,0)
        currentCube.isRootCube = true;
    }

    SequentialAnimation {
        id: hovering
        
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
    antialiasing: true
    
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
        property matrix4x4 scaleYMatrix:
            Qt.matrix4x4(1,   0, 0, 0,
                         0, 0.5, 0, 0,
                         0,   0, 1, 0,
                         0,   0, 0, 1)
        matrix: flipMatrix.times(scaleYMatrix).times(rotationZMatrix)
    }
}
