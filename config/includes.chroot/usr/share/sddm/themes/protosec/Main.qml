// =============================================================================
// Main.qml — Tema de inicio de sesión SDDM para ProtoSec OS 1.0
// Colores: #00FF41 (verde), #0D0D0D (negro), #FF6B35 (naranja),
//          #1A1A2E (azul noche), #E0E0E0 (gris)
// =============================================================================

import QtQuick 2.15
import QtQuick.Controls 2.15
import SddmComponents 2.0

Rectangle {
    id: root
    width: Screen.width
    height: Screen.height
    color: "#1A1A2E"

    // =========================================================================
    // Propiedades auxiliares
    // =========================================================================
    property int sessionIndex: sessionModel.lastIndex

    // =========================================================================
    // Conexiones con el modelo de autenticación
    // =========================================================================
    Connections {
        target: sddm

        function onLoginSucceeded() {
            mensajeError.text = ""
        }

        function onLoginFailed() {
            mensajeError.text = "Inicio de sesión fallido. Inténtalo de nuevo."
            campoContrasena.text = ""
            campoContrasena.focus = true
        }
    }

    // =========================================================================
    // Reloj — esquina superior derecha
    // =========================================================================
    Text {
        id: reloj
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.topMargin: 20
        anchors.rightMargin: 30
        color: "#E0E0E0"
        font.pixelSize: 16
        font.family: "Noto Sans"

        // Actualizar cada segundo
        Timer {
            interval: 1000
            running: true
            repeat: true
            onTriggered: {
                var ahora = new Date()
                var horas = ("0" + ahora.getHours()).slice(-2)
                var minutos = ("0" + ahora.getMinutes()).slice(-2)
                var segundos = ("0" + ahora.getSeconds()).slice(-2)
                var dia = ("0" + ahora.getDate()).slice(-2)
                var mes = ("0" + (ahora.getMonth() + 1)).slice(-2)
                var anio = ahora.getFullYear()
                reloj.text = dia + "/" + mes + "/" + anio + "  " + horas + ":" + minutos + ":" + segundos
            }
        }

        Component.onCompleted: {
            var ahora = new Date()
            var horas = ("0" + ahora.getHours()).slice(-2)
            var minutos = ("0" + ahora.getMinutes()).slice(-2)
            var segundos = ("0" + ahora.getSeconds()).slice(-2)
            var dia = ("0" + ahora.getDate()).slice(-2)
            var mes = ("0" + (ahora.getMonth() + 1)).slice(-2)
            var anio = ahora.getFullYear()
            text = dia + "/" + mes + "/" + anio + "  " + horas + ":" + minutos + ":" + segundos
        }
    }

    // =========================================================================
    // Contenedor central del formulario de inicio de sesión
    // =========================================================================
    Column {
        id: contenedorLogin
        anchors.centerIn: parent
        spacing: 16
        width: 320

        // --- Logo: texto "ProtoSec" ---
        Text {
            text: "ProtoSec"
            color: "#00FF41"
            font.pixelSize: 52
            font.bold: true
            font.family: "Noto Sans"
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }

        // --- Subtítulo / eslogan ---
        Text {
            text: "Hack. Analyze. Deploy."
            color: "#FF6B35"
            font.pixelSize: 16
            font.italic: true
            font.family: "Noto Sans"
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }

        // --- Separador visual ---
        Item { width: 1; height: 24 }

        // --- Campo de usuario ---
        Column {
            width: parent.width
            spacing: 4

            Text {
                text: "Usuario"
                color: "#E0E0E0"
                font.pixelSize: 12
                font.family: "Noto Sans"
            }

            Rectangle {
                width: parent.width
                height: 40
                color: "#0D0D0D"
                border.color: campoUsuario.activeFocus ? "#00FF41" : "#333333"
                border.width: campoUsuario.activeFocus ? 2 : 1
                radius: 4

                TextInput {
                    id: campoUsuario
                    anchors.fill: parent
                    anchors.margins: 8
                    color: "#E0E0E0"
                    font.pixelSize: 14
                    font.family: "Noto Sans"
                    clip: true
                    text: userModel.lastUser

                    KeyNavigation.tab: campoContrasena

                    Keys.onReturnPressed: {
                        sddm.login(campoUsuario.text, campoContrasena.text, sessionIndex)
                    }
                }
            }
        }

        // --- Campo de contraseña ---
        Column {
            width: parent.width
            spacing: 4

            Text {
                text: "Contraseña"
                color: "#E0E0E0"
                font.pixelSize: 12
                font.family: "Noto Sans"
            }

            Rectangle {
                width: parent.width
                height: 40
                color: "#0D0D0D"
                border.color: campoContrasena.activeFocus ? "#00FF41" : "#333333"
                border.width: campoContrasena.activeFocus ? 2 : 1
                radius: 4

                TextInput {
                    id: campoContrasena
                    anchors.fill: parent
                    anchors.margins: 8
                    color: "#E0E0E0"
                    font.pixelSize: 14
                    font.family: "Noto Sans"
                    echoMode: TextInput.Password
                    clip: true

                    KeyNavigation.backtab: campoUsuario
                    KeyNavigation.tab: botonLogin

                    Keys.onReturnPressed: {
                        sddm.login(campoUsuario.text, campoContrasena.text, sessionIndex)
                    }
                }
            }
        }

        // --- Mensaje de error ---
        Text {
            id: mensajeError
            text: ""
            color: "#FF6B35"
            font.pixelSize: 12
            font.family: "Noto Sans"
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            wrapMode: Text.WordWrap
            width: parent.width
        }

        // --- Botón de inicio de sesión ---
        Rectangle {
            id: botonLogin
            width: parent.width
            height: 42
            color: botonLoginArea.containsMouse ? "#33FF66" : "#00FF41"
            radius: 4
            anchors.horizontalCenter: parent.horizontalCenter

            property bool activeFocus: false

            Text {
                anchors.centerIn: parent
                text: "Iniciar sesión"
                color: "#0D0D0D"
                font.pixelSize: 15
                font.bold: true
                font.family: "Noto Sans"
            }

            MouseArea {
                id: botonLoginArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor

                onClicked: {
                    sddm.login(campoUsuario.text, campoContrasena.text, sessionIndex)
                }
            }

            Keys.onReturnPressed: {
                sddm.login(campoUsuario.text, campoContrasena.text, sessionIndex)
            }
        }

        // --- Separador ---
        Item { width: 1; height: 8 }

        // --- Selector de sesión ---
        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 8

            Text {
                text: "Sesión:"
                color: "#E0E0E0"
                font.pixelSize: 12
                font.family: "Noto Sans"
                anchors.verticalCenter: parent.verticalCenter
            }

            ComboBox {
                id: selectorSesion
                width: 200
                model: sessionModel
                textRole: "name"
                currentIndex: root.sessionIndex

                onCurrentIndexChanged: {
                    root.sessionIndex = currentIndex
                }

                background: Rectangle {
                    color: "#0D0D0D"
                    border.color: "#00FF41"
                    border.width: 1
                    radius: 4
                }

                contentItem: Text {
                    text: selectorSesion.displayText
                    color: "#E0E0E0"
                    font.pixelSize: 12
                    font.family: "Noto Sans"
                    verticalAlignment: Text.AlignVCenter
                    leftPadding: 8
                }

                popup: Popup {
                    y: selectorSesion.height
                    width: selectorSesion.width
                    padding: 1

                    background: Rectangle {
                        color: "#0D0D0D"
                        border.color: "#00FF41"
                        border.width: 1
                        radius: 4
                    }

                    contentItem: ListView {
                        implicitHeight: contentHeight
                        model: selectorSesion.delegateModel
                        clip: true
                    }
                }

                delegate: ItemDelegate {
                    width: selectorSesion.width

                    contentItem: Text {
                        text: model.name
                        color: highlighted ? "#0D0D0D" : "#E0E0E0"
                        font.pixelSize: 12
                        font.family: "Noto Sans"
                    }

                    background: Rectangle {
                        color: highlighted ? "#00FF41" : "#0D0D0D"
                    }

                    highlighted: selectorSesion.highlightedIndex === index
                }
            }
        }

        // --- Botones de apagar / reiniciar ---
        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 20

            Text {
                text: "⏻ Apagar"
                color: "#E0E0E0"
                font.pixelSize: 12
                font.family: "Noto Sans"

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: sddm.powerOff()
                }
            }

            Text {
                text: "↻ Reiniciar"
                color: "#E0E0E0"
                font.pixelSize: 12
                font.family: "Noto Sans"

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: sddm.reboot()
                }
            }
        }
    }

    // --- Foco inicial al campo de contraseña si ya hay usuario ---
    Component.onCompleted: {
        if (campoUsuario.text !== "") {
            campoContrasena.focus = true
        } else {
            campoUsuario.focus = true
        }
    }
}
