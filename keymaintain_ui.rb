=begin
** Form generated from reading ui file 'keymaintain.ui'
**
** Created: Thu Jan 15 07:59:28 2015
**      by: Qt User Interface Compiler version 4.8.6
**
** WARNING! All changes made in this file will be lost when recompiling ui file!
=end

class Ui_KeyMaintainDialog
    attr_reader :keyTable
    attr_reader :exitButton
    attr_reader :layoutWidget
    attr_reader :verticalLayout
    attr_reader :addButton
    attr_reader :changeButton
    attr_reader :deleteButton

    def setupUi(keyMaintainDialog)
    if keyMaintainDialog.objectName.nil?
        keyMaintainDialog.objectName = "keyMaintainDialog"
    end
    keyMaintainDialog.resize(1018, 646)
    @keyTable = Qt::TableWidget.new(keyMaintainDialog)
    @keyTable.objectName = "keyTable"
    @keyTable.geometry = Qt::Rect.new(10, 10, 871, 621)
    @exitButton = Qt::PushButton.new(keyMaintainDialog)
    @exitButton.objectName = "exitButton"
    @exitButton.geometry = Qt::Rect.new(900, 210, 114, 32)
    @layoutWidget = Qt::Widget.new(keyMaintainDialog)
    @layoutWidget.objectName = "layoutWidget"
    @layoutWidget.geometry = Qt::Rect.new(900, 30, 111, 121)
    @verticalLayout = Qt::VBoxLayout.new(@layoutWidget)
    @verticalLayout.objectName = "verticalLayout"
    @verticalLayout.setContentsMargins(0, 0, 0, 0)
    @addButton = Qt::PushButton.new(@layoutWidget)
    @addButton.objectName = "addButton"

    @verticalLayout.addWidget(@addButton)

    @changeButton = Qt::PushButton.new(@layoutWidget)
    @changeButton.objectName = "changeButton"

    @verticalLayout.addWidget(@changeButton)

    @deleteButton = Qt::PushButton.new(@layoutWidget)
    @deleteButton.objectName = "deleteButton"

    @verticalLayout.addWidget(@deleteButton)


    retranslateUi(keyMaintainDialog)
    Qt::Object.connect(@addButton, SIGNAL('clicked()'), keyMaintainDialog, SLOT('add_key()'))
    Qt::Object.connect(@changeButton, SIGNAL('clicked()'), keyMaintainDialog, SLOT('change_key()'))
    Qt::Object.connect(@deleteButton, SIGNAL('clicked()'), keyMaintainDialog, SLOT('delete_key()'))
    Qt::Object.connect(@exitButton, SIGNAL('clicked()'), keyMaintainDialog, SLOT('accept()'))

    Qt::MetaObject.connectSlotsByName(keyMaintainDialog)
    end # setupUi

    def setup_ui(keyMaintainDialog)
        setupUi(keyMaintainDialog)
    end

    def retranslateUi(keyMaintainDialog)
    keyMaintainDialog.windowTitle = Qt::Application.translate("KeyMaintainDialog", "Dialog", nil, Qt::Application::UnicodeUTF8)
    @exitButton.text = Qt::Application.translate("KeyMaintainDialog", "Exit", nil, Qt::Application::UnicodeUTF8)
    @addButton.text = Qt::Application.translate("KeyMaintainDialog", "Add", nil, Qt::Application::UnicodeUTF8)
    @changeButton.text = Qt::Application.translate("KeyMaintainDialog", "Change", nil, Qt::Application::UnicodeUTF8)
    @deleteButton.text = Qt::Application.translate("KeyMaintainDialog", "Delete", nil, Qt::Application::UnicodeUTF8)
    end # retranslateUi

    def retranslate_ui(keyMaintainDialog)
        retranslateUi(keyMaintainDialog)
    end

end

module Ui
    class KeyMaintainDialog < Ui_KeyMaintainDialog
    end
end  # module Ui

