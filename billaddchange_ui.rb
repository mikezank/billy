=begin
** Form generated from reading ui file 'billaddchange.ui'
**
** Created: Mon Jan 12 16:39:06 2015
**      by: Qt User Interface Compiler version 4.8.6
**
** WARNING! All changes made in this file will be lost when recompiling ui file!
=end

class Ui_MaintDialog
    attr_reader :groupBox
    attr_reader :radioButton
    attr_reader :monthlyButton
    attr_reader :weeklyButton
    attr_reader :semiButton
    attr_reader :dailyButton
    attr_reader :layoutWidget_2
    attr_reader :horizontalLayout_4
    attr_reader :label_9
    attr_reader :weekSpin
    attr_reader :label_10
    attr_reader :weekCombo
    attr_reader :layoutWidget_3
    attr_reader :horizontalLayout_7
    attr_reader :label_11
    attr_reader :daySpin
    attr_reader :label_12
    attr_reader :errorMsg
    attr_reader :layoutWidget
    attr_reader :horizontalLayout_3
    attr_reader :label_4
    attr_reader :monthSpin
    attr_reader :label_6
    attr_reader :monthCombo
    attr_reader :label_8
    attr_reader :layoutWidget1
    attr_reader :horizontalLayout_8
    attr_reader :label_14
    attr_reader :semiCombo1
    attr_reader :label_17
    attr_reader :semiCombo2
    attr_reader :label_16
    attr_reader :layoutWidget2
    attr_reader :horizontalLayout_9
    attr_reader :label_3
    attr_reader :nameEdit
    attr_reader :label_5
    attr_reader :amountSpin
    attr_reader :layoutWidget3
    attr_reader :horizontalLayout
    attr_reader :startCheck
    attr_reader :startdateEdit
    attr_reader :endCheck
    attr_reader :enddateEdit
    attr_reader :layoutWidget4
    attr_reader :horizontalLayout_2
    attr_reader :label_7
    attr_reader :urlEdit
    attr_reader :widget
    attr_reader :horizontalLayout_5
    attr_reader :pushButton_2
    attr_reader :clearButton
    attr_reader :doneButton

    def setupUi(maintDialog)
    if maintDialog.objectName.nil?
        maintDialog.objectName = "maintDialog"
    end
    maintDialog.resize(673, 488)
    @groupBox = Qt::GroupBox.new(maintDialog)
    @groupBox.objectName = "groupBox"
    @groupBox.geometry = Qt::Rect.new(30, 60, 131, 201)
    @radioButton = Qt::RadioButton.new(@groupBox)
    @radioButton.objectName = "radioButton"
    @radioButton.geometry = Qt::Rect.new(10, -220, 102, 20)
    @monthlyButton = Qt::RadioButton.new(@groupBox)
    @monthlyButton.objectName = "monthlyButton"
    @monthlyButton.geometry = Qt::Rect.new(10, 40, 75, 20)
    @weeklyButton = Qt::RadioButton.new(@groupBox)
    @weeklyButton.objectName = "weeklyButton"
    @weeklyButton.geometry = Qt::Rect.new(10, 80, 111, 20)
    @semiButton = Qt::RadioButton.new(@groupBox)
    @semiButton.objectName = "semiButton"
    @semiButton.geometry = Qt::Rect.new(10, 160, 111, 20)
    @dailyButton = Qt::RadioButton.new(@groupBox)
    @dailyButton.objectName = "dailyButton"
    @dailyButton.geometry = Qt::Rect.new(10, 120, 69, 20)
    @layoutWidget_2 = Qt::Widget.new(maintDialog)
    @layoutWidget_2.objectName = "layoutWidget_2"
    @layoutWidget_2.geometry = Qt::Rect.new(190, 140, 271, 30)
    @horizontalLayout_4 = Qt::HBoxLayout.new(@layoutWidget_2)
    @horizontalLayout_4.spacing = -1
    @horizontalLayout_4.objectName = "horizontalLayout_4"
    @horizontalLayout_4.setContentsMargins(0, 0, 0, 0)
    @label_9 = Qt::Label.new(@layoutWidget_2)
    @label_9.objectName = "label_9"

    @horizontalLayout_4.addWidget(@label_9)

    @weekSpin = Qt::SpinBox.new(@layoutWidget_2)
    @weekSpin.objectName = "weekSpin"

    @horizontalLayout_4.addWidget(@weekSpin)

    @label_10 = Qt::Label.new(@layoutWidget_2)
    @label_10.objectName = "label_10"

    @horizontalLayout_4.addWidget(@label_10)

    @weekCombo = Qt::ComboBox.new(@layoutWidget_2)
    @weekCombo.objectName = "weekCombo"

    @horizontalLayout_4.addWidget(@weekCombo)

    @layoutWidget_3 = Qt::Widget.new(maintDialog)
    @layoutWidget_3.objectName = "layoutWidget_3"
    @layoutWidget_3.geometry = Qt::Rect.new(190, 180, 141, 30)
    @horizontalLayout_7 = Qt::HBoxLayout.new(@layoutWidget_3)
    @horizontalLayout_7.objectName = "horizontalLayout_7"
    @horizontalLayout_7.setContentsMargins(0, 0, 0, 0)
    @label_11 = Qt::Label.new(@layoutWidget_3)
    @label_11.objectName = "label_11"

    @horizontalLayout_7.addWidget(@label_11)

    @daySpin = Qt::SpinBox.new(@layoutWidget_3)
    @daySpin.objectName = "daySpin"

    @horizontalLayout_7.addWidget(@daySpin)

    @label_12 = Qt::Label.new(@layoutWidget_3)
    @label_12.objectName = "label_12"

    @horizontalLayout_7.addWidget(@label_12)

    @errorMsg = Qt::Label.new(maintDialog)
    @errorMsg.objectName = "errorMsg"
    @errorMsg.geometry = Qt::Rect.new(30, 430, 611, 20)
    @errorMsg.frameShape = Qt::Frame::Panel
    @errorMsg.frameShadow = Qt::Frame::Sunken
    @layoutWidget = Qt::Widget.new(maintDialog)
    @layoutWidget.objectName = "layoutWidget"
    @layoutWidget.geometry = Qt::Rect.new(190, 100, 386, 30)
    @horizontalLayout_3 = Qt::HBoxLayout.new(@layoutWidget)
    @horizontalLayout_3.objectName = "horizontalLayout_3"
    @horizontalLayout_3.setContentsMargins(0, 0, 0, 0)
    @label_4 = Qt::Label.new(@layoutWidget)
    @label_4.objectName = "label_4"

    @horizontalLayout_3.addWidget(@label_4)

    @monthSpin = Qt::SpinBox.new(@layoutWidget)
    @monthSpin.objectName = "monthSpin"

    @horizontalLayout_3.addWidget(@monthSpin)

    @label_6 = Qt::Label.new(@layoutWidget)
    @label_6.objectName = "label_6"

    @horizontalLayout_3.addWidget(@label_6)

    @monthCombo = Qt::ComboBox.new(@layoutWidget)
    @monthCombo.objectName = "monthCombo"

    @horizontalLayout_3.addWidget(@monthCombo)

    @label_8 = Qt::Label.new(@layoutWidget)
    @label_8.objectName = "label_8"

    @horizontalLayout_3.addWidget(@label_8)

    @layoutWidget1 = Qt::Widget.new(maintDialog)
    @layoutWidget1.objectName = "layoutWidget1"
    @layoutWidget1.geometry = Qt::Rect.new(191, 220, 399, 26)
    @horizontalLayout_8 = Qt::HBoxLayout.new(@layoutWidget1)
    @horizontalLayout_8.objectName = "horizontalLayout_8"
    @horizontalLayout_8.setContentsMargins(0, 0, 0, 0)
    @label_14 = Qt::Label.new(@layoutWidget1)
    @label_14.objectName = "label_14"

    @horizontalLayout_8.addWidget(@label_14)

    @semiCombo1 = Qt::ComboBox.new(@layoutWidget1)
    @semiCombo1.objectName = "semiCombo1"

    @horizontalLayout_8.addWidget(@semiCombo1)

    @label_17 = Qt::Label.new(@layoutWidget1)
    @label_17.objectName = "label_17"

    @horizontalLayout_8.addWidget(@label_17)

    @semiCombo2 = Qt::ComboBox.new(@layoutWidget1)
    @semiCombo2.objectName = "semiCombo2"

    @horizontalLayout_8.addWidget(@semiCombo2)

    @label_16 = Qt::Label.new(@layoutWidget1)
    @label_16.objectName = "label_16"

    @horizontalLayout_8.addWidget(@label_16)

    @layoutWidget2 = Qt::Widget.new(maintDialog)
    @layoutWidget2.objectName = "layoutWidget2"
    @layoutWidget2.geometry = Qt::Rect.new(33, 20, 591, 26)
    @horizontalLayout_9 = Qt::HBoxLayout.new(@layoutWidget2)
    @horizontalLayout_9.objectName = "horizontalLayout_9"
    @horizontalLayout_9.setContentsMargins(0, 0, 0, 0)
    @label_3 = Qt::Label.new(@layoutWidget2)
    @label_3.objectName = "label_3"

    @horizontalLayout_9.addWidget(@label_3)

    @nameEdit = Qt::LineEdit.new(@layoutWidget2)
    @nameEdit.objectName = "nameEdit"

    @horizontalLayout_9.addWidget(@nameEdit)

    @label_5 = Qt::Label.new(@layoutWidget2)
    @label_5.objectName = "label_5"

    @horizontalLayout_9.addWidget(@label_5)

    @amountSpin = Qt::DoubleSpinBox.new(@layoutWidget2)
    @amountSpin.objectName = "amountSpin"

    @horizontalLayout_9.addWidget(@amountSpin)

    @layoutWidget3 = Qt::Widget.new(maintDialog)
    @layoutWidget3.objectName = "layoutWidget3"
    @layoutWidget3.geometry = Qt::Rect.new(40, 280, 357, 31)
    @horizontalLayout = Qt::HBoxLayout.new(@layoutWidget3)
    @horizontalLayout.objectName = "horizontalLayout"
    @horizontalLayout.setContentsMargins(0, 0, 0, 0)
    @startCheck = Qt::CheckBox.new(@layoutWidget3)
    @startCheck.objectName = "startCheck"

    @horizontalLayout.addWidget(@startCheck)

    @startdateEdit = Qt::DateEdit.new(@layoutWidget3)
    @startdateEdit.objectName = "startdateEdit"

    @horizontalLayout.addWidget(@startdateEdit)

    @endCheck = Qt::CheckBox.new(@layoutWidget3)
    @endCheck.objectName = "endCheck"

    @horizontalLayout.addWidget(@endCheck)

    @enddateEdit = Qt::DateEdit.new(@layoutWidget3)
    @enddateEdit.objectName = "enddateEdit"

    @horizontalLayout.addWidget(@enddateEdit)

    @layoutWidget4 = Qt::Widget.new(maintDialog)
    @layoutWidget4.objectName = "layoutWidget4"
    @layoutWidget4.geometry = Qt::Rect.new(41, 330, 611, 23)
    @horizontalLayout_2 = Qt::HBoxLayout.new(@layoutWidget4)
    @horizontalLayout_2.objectName = "horizontalLayout_2"
    @horizontalLayout_2.setContentsMargins(0, 0, 0, 0)
    @label_7 = Qt::Label.new(@layoutWidget4)
    @label_7.objectName = "label_7"

    @horizontalLayout_2.addWidget(@label_7)

    @urlEdit = Qt::LineEdit.new(@layoutWidget4)
    @urlEdit.objectName = "urlEdit"

    @horizontalLayout_2.addWidget(@urlEdit)

    @widget = Qt::Widget.new(maintDialog)
    @widget.objectName = "widget"
    @widget.geometry = Qt::Rect.new(30, 379, 621, 32)
    @horizontalLayout_5 = Qt::HBoxLayout.new(@widget)
    @horizontalLayout_5.objectName = "horizontalLayout_5"
    @horizontalLayout_5.setContentsMargins(0, 0, 0, 0)
    @pushButton_2 = Qt::PushButton.new(@widget)
    @pushButton_2.objectName = "pushButton_2"

    @horizontalLayout_5.addWidget(@pushButton_2)

    @clearButton = Qt::PushButton.new(@widget)
    @clearButton.objectName = "clearButton"

    @horizontalLayout_5.addWidget(@clearButton)

    @doneButton = Qt::PushButton.new(@widget)
    @doneButton.objectName = "doneButton"

    @horizontalLayout_5.addWidget(@doneButton)

    layoutWidget.raise()
    layoutWidget.raise()
    layoutWidget.raise()
    layoutWidget.raise()
    layoutWidget.raise()
    pushButton_2.raise()
    doneButton.raise()
    groupBox.raise()
    layoutWidget_2.raise()
    layoutWidget_3.raise()
    errorMsg.raise()
    clearButton.raise()

    retranslateUi(maintDialog)
    Qt::Object.connect(@pushButton_2, SIGNAL('clicked()'), maintDialog, SLOT('save_clicked()'))
    Qt::Object.connect(@doneButton, SIGNAL('clicked()'), maintDialog, SLOT('reject()'))
    Qt::Object.connect(@monthlyButton, SIGNAL('clicked()'), maintDialog, SLOT('monthly_period_clicked()'))
    Qt::Object.connect(@weeklyButton, SIGNAL('clicked()'), maintDialog, SLOT('weekly_period_clicked()'))
    Qt::Object.connect(@dailyButton, SIGNAL('clicked()'), maintDialog, SLOT('daily_period_clicked()'))
    Qt::Object.connect(@semiButton, SIGNAL('clicked()'), maintDialog, SLOT('semi_period_clicked()'))
    Qt::Object.connect(@endCheck, SIGNAL('clicked()'), maintDialog, SLOT('end_date_check()'))
    Qt::Object.connect(@startCheck, SIGNAL('clicked()'), maintDialog, SLOT('start_date_check()'))
    Qt::Object.connect(@clearButton, SIGNAL('clicked()'), maintDialog, SLOT('clear_clicked()'))

    Qt::MetaObject.connectSlotsByName(maintDialog)
    end # setupUi

    def setup_ui(maintDialog)
        setupUi(maintDialog)
    end

    def retranslateUi(maintDialog)
    maintDialog.windowTitle = Qt::Application.translate("maintDialog", "Dialog", nil, Qt::Application::UnicodeUTF8)
    @groupBox.title = Qt::Application.translate("maintDialog", "Frequency", nil, Qt::Application::UnicodeUTF8)
    @radioButton.text = Qt::Application.translate("maintDialog", "RadioButton", nil, Qt::Application::UnicodeUTF8)
    @monthlyButton.text = Qt::Application.translate("maintDialog", "Monthly", nil, Qt::Application::UnicodeUTF8)
    @weeklyButton.text = Qt::Application.translate("maintDialog", "Weekly", nil, Qt::Application::UnicodeUTF8)
    @semiButton.text = Qt::Application.translate("maintDialog", "Semi-monthly", nil, Qt::Application::UnicodeUTF8)
    @dailyButton.text = Qt::Application.translate("maintDialog", "Daily", nil, Qt::Application::UnicodeUTF8)
    @label_9.text = Qt::Application.translate("maintDialog", "Every", nil, Qt::Application::UnicodeUTF8)
    @label_10.text = Qt::Application.translate("maintDialog", "Weeks on", nil, Qt::Application::UnicodeUTF8)
    @label_11.text = Qt::Application.translate("maintDialog", "Every", nil, Qt::Application::UnicodeUTF8)
    @label_12.text = Qt::Application.translate("maintDialog", "Days", nil, Qt::Application::UnicodeUTF8)
    @errorMsg.text = ''
    @label_4.text = Qt::Application.translate("maintDialog", "Every", nil, Qt::Application::UnicodeUTF8)
    @label_6.text = Qt::Application.translate("maintDialog", "Months on the", nil, Qt::Application::UnicodeUTF8)
    @label_8.text = Qt::Application.translate("maintDialog", "of the month", nil, Qt::Application::UnicodeUTF8)
    @label_14.text = Qt::Application.translate("maintDialog", "on the", nil, Qt::Application::UnicodeUTF8)
    @label_17.text = Qt::Application.translate("maintDialog", "and the", nil, Qt::Application::UnicodeUTF8)
    @label_16.text = Qt::Application.translate("maintDialog", "of the month", nil, Qt::Application::UnicodeUTF8)
    @label_3.text = Qt::Application.translate("maintDialog", "Name", nil, Qt::Application::UnicodeUTF8)
    @label_5.text = Qt::Application.translate("maintDialog", "Amount", nil, Qt::Application::UnicodeUTF8)
    @startCheck.text = Qt::Application.translate("maintDialog", "Start Date", nil, Qt::Application::UnicodeUTF8)
    @endCheck.text = Qt::Application.translate("maintDialog", "End Date", nil, Qt::Application::UnicodeUTF8)
    @label_7.text = Qt::Application.translate("maintDialog", "Bill Pay URL", nil, Qt::Application::UnicodeUTF8)
    @pushButton_2.text = Qt::Application.translate("maintDialog", "Save", nil, Qt::Application::UnicodeUTF8)
    @clearButton.text = Qt::Application.translate("maintDialog", "Clear", nil, Qt::Application::UnicodeUTF8)
    @doneButton.text = Qt::Application.translate("maintDialog", "Done", nil, Qt::Application::UnicodeUTF8)
    end # retranslateUi

    def retranslate_ui(maintDialog)
        retranslateUi(maintDialog)
    end

end

module Ui
    class MaintDialog < Ui_MaintDialog
    end
end  # module Ui

