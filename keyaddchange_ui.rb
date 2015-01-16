=begin
** Form generated from reading ui file 'keyaddchange.ui'
**
** Created: Thu Jan 15 09:16:15 2015
**      by: Qt User Interface Compiler version 4.8.6
**
** WARNING! All changes made in this file will be lost when recompiling ui file!
=end

class Ui_KeyAddChangeDialog
    attr_reader :widget
    attr_reader :gridLayout
    attr_reader :label
    attr_reader :nameEdit
    attr_reader :label_2
    attr_reader :info1Edit
    attr_reader :info1Check
    attr_reader :code1Edit
    attr_reader :label_3
    attr_reader :info2Edit
    attr_reader :info2Check
    attr_reader :code2Edit
    attr_reader :label_4
    attr_reader :info3Edit
    attr_reader :info3Check
    attr_reader :code3Edit
    attr_reader :label_5
    attr_reader :info4Edit
    attr_reader :info4Check
    attr_reader :code4Edit
    attr_reader :widget1
    attr_reader :horizontalLayout
    attr_reader :pushButton
    attr_reader :pushButton_2

    def setupUi(keyAddChangeDialog)
    if keyAddChangeDialog.objectName.nil?
        keyAddChangeDialog.objectName = "keyAddChangeDialog"
    end
    keyAddChangeDialog.resize(949, 338)
    @widget = Qt::Widget.new(keyAddChangeDialog)
    @widget.objectName = "widget"
    @widget.geometry = Qt::Rect.new(20, 10, 891, 261)
    @gridLayout = Qt::GridLayout.new(@widget)
    @gridLayout.objectName = "gridLayout"
    @gridLayout.setContentsMargins(0, 0, 0, 0)
    @label = Qt::Label.new(@widget)
    @label.objectName = "label"
    @font = Qt::Font.new
    @font.pointSize = 16
    @label.font = @font

    @gridLayout.addWidget(@label, 0, 0, 1, 1)

    @nameEdit = Qt::LineEdit.new(@widget)
    @nameEdit.objectName = "nameEdit"

    @gridLayout.addWidget(@nameEdit, 0, 1, 1, 1)

    @label_2 = Qt::Label.new(@widget)
    @label_2.objectName = "label_2"
    @label_2.font = @font

    @gridLayout.addWidget(@label_2, 1, 0, 1, 1)

    @info1Edit = Qt::LineEdit.new(@widget)
    @info1Edit.objectName = "info1Edit"

    @gridLayout.addWidget(@info1Edit, 1, 1, 1, 1)

    @info1Check = Qt::CheckBox.new(@widget)
    @info1Check.objectName = "info1Check"

    @gridLayout.addWidget(@info1Check, 1, 2, 1, 1)

    @code1Edit = Qt::LineEdit.new(@widget)
    @code1Edit.objectName = "code1Edit"

    @gridLayout.addWidget(@code1Edit, 1, 3, 1, 1)

    @label_3 = Qt::Label.new(@widget)
    @label_3.objectName = "label_3"
    @label_3.font = @font

    @gridLayout.addWidget(@label_3, 2, 0, 1, 1)

    @info2Edit = Qt::LineEdit.new(@widget)
    @info2Edit.objectName = "info2Edit"

    @gridLayout.addWidget(@info2Edit, 2, 1, 1, 1)

    @info2Check = Qt::CheckBox.new(@widget)
    @info2Check.objectName = "info2Check"

    @gridLayout.addWidget(@info2Check, 2, 2, 1, 1)

    @code2Edit = Qt::LineEdit.new(@widget)
    @code2Edit.objectName = "code2Edit"

    @gridLayout.addWidget(@code2Edit, 2, 3, 1, 1)

    @label_4 = Qt::Label.new(@widget)
    @label_4.objectName = "label_4"
    @label_4.font = @font

    @gridLayout.addWidget(@label_4, 3, 0, 1, 1)

    @info3Edit = Qt::LineEdit.new(@widget)
    @info3Edit.objectName = "info3Edit"

    @gridLayout.addWidget(@info3Edit, 3, 1, 1, 1)

    @info3Check = Qt::CheckBox.new(@widget)
    @info3Check.objectName = "info3Check"

    @gridLayout.addWidget(@info3Check, 3, 2, 1, 1)

    @code3Edit = Qt::LineEdit.new(@widget)
    @code3Edit.objectName = "code3Edit"

    @gridLayout.addWidget(@code3Edit, 3, 3, 1, 1)

    @label_5 = Qt::Label.new(@widget)
    @label_5.objectName = "label_5"
    @label_5.font = @font

    @gridLayout.addWidget(@label_5, 4, 0, 1, 1)

    @info4Edit = Qt::LineEdit.new(@widget)
    @info4Edit.objectName = "info4Edit"

    @gridLayout.addWidget(@info4Edit, 4, 1, 1, 1)

    @info4Check = Qt::CheckBox.new(@widget)
    @info4Check.objectName = "info4Check"

    @gridLayout.addWidget(@info4Check, 4, 2, 1, 1)

    @code4Edit = Qt::LineEdit.new(@widget)
    @code4Edit.objectName = "code4Edit"

    @gridLayout.addWidget(@code4Edit, 4, 3, 1, 1)

    @widget1 = Qt::Widget.new(keyAddChangeDialog)
    @widget1.objectName = "widget1"
    @widget1.geometry = Qt::Rect.new(660, 290, 251, 32)
    @horizontalLayout = Qt::HBoxLayout.new(@widget1)
    @horizontalLayout.objectName = "horizontalLayout"
    @horizontalLayout.setContentsMargins(0, 0, 0, 0)
    @pushButton = Qt::PushButton.new(@widget1)
    @pushButton.objectName = "pushButton"

    @horizontalLayout.addWidget(@pushButton)

    @pushButton_2 = Qt::PushButton.new(@widget1)
    @pushButton_2.objectName = "pushButton_2"

    @horizontalLayout.addWidget(@pushButton_2)


    retranslateUi(keyAddChangeDialog)
    Qt::Object.connect(@pushButton, SIGNAL('clicked()'), keyAddChangeDialog, SLOT('reject()'))
    Qt::Object.connect(@pushButton_2, SIGNAL('clicked()'), keyAddChangeDialog, SLOT('save_clicked()'))
    Qt::Object.connect(@info1Check, SIGNAL('clicked()'), keyAddChangeDialog, SLOT('code_clicked()'))
    Qt::Object.connect(@info2Check, SIGNAL('clicked()'), keyAddChangeDialog, SLOT('code_clicked()'))
    Qt::Object.connect(@info3Check, SIGNAL('clicked()'), keyAddChangeDialog, SLOT('code_clicked()'))
    Qt::Object.connect(@info4Check, SIGNAL('clicked()'), keyAddChangeDialog, SLOT('code_clicked()'))

    Qt::MetaObject.connectSlotsByName(keyAddChangeDialog)
    end # setupUi

    def setup_ui(keyAddChangeDialog)
        setupUi(keyAddChangeDialog)
    end

    def retranslateUi(keyAddChangeDialog)
    keyAddChangeDialog.windowTitle = Qt::Application.translate("KeyAddChangeDialog", "Dialog", nil, Qt::Application::UnicodeUTF8)
    @label.text = Qt::Application.translate("KeyAddChangeDialog", "Key Name", nil, Qt::Application::UnicodeUTF8)
    @label_2.text = Qt::Application.translate("KeyAddChangeDialog", "Info Field 1", nil, Qt::Application::UnicodeUTF8)
    @info1Check.text = Qt::Application.translate("KeyAddChangeDialog", "Encrypted value is", nil, Qt::Application::UnicodeUTF8)
    @label_3.text = Qt::Application.translate("KeyAddChangeDialog", "Info Field 2", nil, Qt::Application::UnicodeUTF8)
    @info2Check.text = Qt::Application.translate("KeyAddChangeDialog", "Encrypted value is", nil, Qt::Application::UnicodeUTF8)
    @label_4.text = Qt::Application.translate("KeyAddChangeDialog", "Info Field 3", nil, Qt::Application::UnicodeUTF8)
    @info3Check.text = Qt::Application.translate("KeyAddChangeDialog", "Encrypted value is", nil, Qt::Application::UnicodeUTF8)
    @label_5.text = Qt::Application.translate("KeyAddChangeDialog", "Info Field 4", nil, Qt::Application::UnicodeUTF8)
    @info4Check.text = Qt::Application.translate("KeyAddChangeDialog", "Encrypted value is", nil, Qt::Application::UnicodeUTF8)
    @pushButton.text = Qt::Application.translate("KeyAddChangeDialog", "Cancel", nil, Qt::Application::UnicodeUTF8)
    @pushButton_2.text = Qt::Application.translate("KeyAddChangeDialog", "Save", nil, Qt::Application::UnicodeUTF8)
    end # retranslateUi

    def retranslate_ui(keyAddChangeDialog)
        retranslateUi(keyAddChangeDialog)
    end

end

module Ui
    class KeyAddChangeDialog < Ui_KeyAddChangeDialog
    end
end  # module Ui

