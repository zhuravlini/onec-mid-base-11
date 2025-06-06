
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
    // СтандартныеПодсистемы.ПодключаемыеКоманды
    ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
    // Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
    // СтандартныеПодсистемы.ПодключаемыеКоманды
    ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
    // Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
    ПодключаемыеКомандыКлиент.ПослеЗаписи(ЭтотОбъект, Объект, ПараметрыЗаписи);
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыТовары

&НаКлиенте
Процедура ТоварыКоличествоПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыЦенаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыПриИзменении(Элемент)
	РассчитатьСуммуДокумента();
КонецПроцедуры

&НаКлиенте
Процедура ТоварыСкидкаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыУслуги

&НаКлиенте
Процедура УслугиКоличествоПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Услуги.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура УслугиЦенаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Услуги.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура УслугиСкидкаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Услуги.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура УслугиПриИзменении(Элемент)
	РассчитатьСуммуДокумента();
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура РассчитатьСуммуСтроки(ТекущиеДанные)
	
	// {{Журавлева Т.Г. Замена процедуры расчета на расчет со скидкой
	//ТекущиеДанные.Сумма = ТекущиеДанные.Цена * ТекущиеДанные.Количество;
	ПересчитатьСуммуСтрокиСоСкидкой(ТекущиеДанные);
	
	РассчитатьСуммуДокумента();
	// }}
КонецПроцедуры

&НаКлиенте
Процедура РассчитатьСуммуДокумента()
	
	Объект.СуммаДокумента = Объект.Товары.Итог("Сумма") + Объект.Услуги.Итог("Сумма");
	
КонецПроцедуры

#Область ДЗ_ДомашнееЗадание

&НаКлиенте
Процедура ПересчитатьСуммуСтрокиСоСкидкой(ТекущиеДанные)
	//Журавлева Т.Г. Расчет суммы строки со скидкой
	ОбщаяСкидка = ТекущиеДанные.Скидка + Объект.ДЗ_СогласованнаяСкидка;
	ПревышениеСкидки = ОбщаяСкидка - 100;
	Если ОбщаяСкидка > 100 Тогда
		Сообщение = Новый СообщениеПользователю();
		Сообщение.Текст = СтрШаблон("Сумма скидки в строке и согласованной скидки не может превышать 100%%, уменьшите любое из этих значений на %1%%", ПревышениеСкидки);
		Сообщение.Сообщить();
		Возврат;
	КонецЕсли;
	
	Если ОбщаяСкидка = 0 Тогда
		ТекущиеДанные.Сумма = ТекущиеДанные.Цена * ТекущиеДанные.Количество;
	Иначе
		ТекущиеДанные.Сумма = ТекущиеДанные.Цена * ТекущиеДанные.Количество * (1 - ОбщаяСкидка / 100);
	КонецЕсли;
	//-- 
КонецПроцедуры

&НаКлиенте
Процедура ДЗ_ПересчитатьТаблицу(Команда)
	// Журавлева Т.Г. Команда пересчета всей табличной части со скидкой
	ПересчитатьТаблицуЦеликомСоСкидкой();
	РассчитатьСуммуДокумента();
	//--
КонецПроцедуры

&НаКлиенте
Процедура ПересчитатьТаблицуЦеликомСоСкидкой()
	// Журавлева Т.Г. Служебная процедура для команды пересчета всей табличной части со скидкой
	Для Каждого Товар Из Объект.Товары Цикл
		ПересчитатьСуммуСтрокиСоСкидкой(Товар);
	КонецЦикла;
	
	Для Каждого Услуга Из Объект.Услуги Цикл
		ПересчитатьСуммуСтрокиСоСкидкой(Услуга);
	КонецЦикла;
	//--
КонецПроцедуры

&НаКлиенте
Процедура ДЗ_СогласованнаяСкидкаПриИзменении(Элемент)
	// Журавлева Т.Г. Обработчик события с вопросом о пересчете всей табличной части со скидкой
	Если ЗначениеЗаполнено(Объект.Товары) Или ЗначениеЗаполнено(Объект.Услуги) Тогда
		ЗадатьВопросОПересчете();
	КонецЕсли;
	//--
КонецПроцедуры
&НаКлиенте

Асинх Процедура ЗадатьВопросОПересчете()
	// Журавлева Т.Г. Служебная процедура для обработчика события с вопросом о пересчете всей табличной части со скидкой
	Режим = РежимДиалогаВопрос.ДаНет;
	Ответ = Ждать ВопросАсинх("Изменен процент скидки. Пересчитать таблицы товаров и услуг?", Режим,0);
	
	Если Ответ = КодВозвратаДиалога.Нет Тогда
		Возврат;
	Иначе
		ПересчитатьТаблицуЦеликомСоСкидкой();
	КонецЕсли;
	РассчитатьСуммуДокумента();
	//--
КонецПроцедуры

#КонецОбласти

#Область ПодключаемыеКоманды

// СтандартныеПодсистемы.ПодключаемыеКоманды
&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
    ПодключаемыеКомандыКлиент.НачатьВыполнениеКоманды(ЭтотОбъект, Команда, Объект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПродолжитьВыполнениеКомандыНаСервере(ПараметрыВыполнения, ДополнительныеПараметры) Экспорт
    ВыполнитьКомандуНаСервере(ПараметрыВыполнения);
КонецПроцедуры

&НаСервере
Процедура ВыполнитьКомандуНаСервере(ПараметрыВыполнения)
    ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, ПараметрыВыполнения, Объект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
    ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
КонецПроцедуры
// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

#КонецОбласти

#КонецОбласти


