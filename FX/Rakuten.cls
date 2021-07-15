/// RECORDMAP: Modified during compilation of RecordMap 'FX.Rakuten'
/// on 2019-10-18 at 15:40:38.882 [2019-10-18 06:40:38.882 UTC]
/// by user UnknownUser
Class FX.Rakuten Extends EnsLib.RecordMap.RecordMap
{

Parameter OBJECTNAME = "FX.Rakuten.Record";

/// Method to retrieve a record from a stream or device. This method will be generated based on the
/// structure of the RecordMap. For testing purposes, a file name may be passed in the pStream argument.
ClassMethod GetObject(pStream As %IO.DeviceStream, Output pObject As %RegisteredObject, pTimeout As %Numeric = -1, ByRef pLookAhead As %String = "", pLabelFound As %Boolean = 0) As %Status
{
	Try {
		Set tStatus = $$$OK
		Set pObject = $$$NULLOREF
		If '$IsObject(pStream) {
			Set tFilename = pStream
			Set pStream = ##class(%IO.FileStream).%New()
			Do pStream.Open(tFilename,,pTimeout,"UTF-8", .tStatus)
			If $$$ISERR(tStatus) Quit
		}
		Set tObjectName = $parameter($this,"OBJECTNAME")
		Set tObject = $classmethod(tObjectName,"%New")
		If '$IsObject(tObject) {
			Set tStatus = $$$ERROR($$$CannotCreateObject,tObjectName)
			Quit
		}
		Set tObject.%Source = pStream.Name
		Set tGetTopFields = $parameter(tObject,"INCLUDETOPFIELDS")
		If pStream.AtEnd && (""=pLookAhead) {
			Set tStatus = $$$ERROR($$$EnsRecordMapErrStreamAtEnd, pStream.Name)
			Quit
		}
		Set pStream.CharEncoding = "UTF-8"

		#; Parse incoming stream
		Set tStatus = ..GetRecord(pStream, tObject, tGetTopFields, pTimeout, .pLookAhead, pLabelFound)
		If $$$ISERR(tStatus) Quit
	}
	Catch ex {
		Set tStatus = ex.AsStatus()
	}
	If $$$ISERR(tStatus) { Set pObject = $$$NULLOREF }
	Else { Set pObject = tObject }
	Quit tStatus
}

/// Method to write a record to a stream or device. This method will be generated based on the
/// structure of the RecordMap. For testing purposes, a file name may be passed in the pStream argument.
ClassMethod PutObject(pStream As %IO.DeviceStream, pObject As %RegisteredObject, pFlush As %Boolean = 1, ByRef pPadArray As %String) As %Status
{
	Try {
		Set tStatus = $$$OK
		If '$IsObject(pStream) {
			Set tFilename = pStream
			Set pStream = ##class(%IO.FileStream).%New()
			Do pStream.Open(tFilename,"WAE",,"UTF-8", .tStatus)
			If $$$ISERR(tStatus) Quit
		}
		Set tHasTopFields = $parameter(pObject,"INCLUDETOPFIELDS")
		Set pStream.CharEncoding = "UTF-8"

		Set tStatus = ..PutRecord(pStream, pObject, tHasTopFields, .pPadArray)
		If $$$ISERR(tStatus) Quit
		If pFlush Do pStream.Flush(.tStatus)
		If $$$ISERR(tStatus) Quit
	}
	Catch ex {
		Set tStatus = ex.AsStatus()
	}
	Quit tStatus
}

/// Internal helper method to perform parse of incoming data
ClassMethod GetRecord(pStream As %IO.DeviceStream, pObject As %RegisteredObject, pGetTopFields As %Boolean, pTimeout As %Numeric, ByRef pLookAhead As %String = "", pLabelFound As %Boolean = 0) As %Status [ Internal, Private ]
{
	Set tStatus = $$$OK
	If pLabelFound { Set tRecLabel = "" } 
	Else { Set tRecLabel = "" } 
	Set tStatus = ..chunkRecord(pStream, .tRecordData, .tCharCount, "", pTimeout, $char(10), tRecLabel, .pLookAhead, $char(34))
	If $$$ISERR(tStatus) Quit tStatus
	Set tMaxLocal = $$$MaxLocalLength
	Set tRecordData("charcount") = +$get(tCharCount)
	Set tCurrChunk = 1
	Set tTopPiece = 1
	Set tCurrSep = 1
	Set tStrings = 1
	Set tCurrString = ""
	Set tSeps = $listbuild($char(44))
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(44), tTopPiece)
	}
	Else {
		Set tCurrString = tRecordData(tCurrChunk)
		Set tCurrPiece = 1
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(44), .tTopPiece)
	If pGetTopFields {
		Set pObject.ExecutionNo =  pObject.ExecutionNoDisplayToLogical(tCurrString)
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(44), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(44), .tTopPiece)
	If pGetTopFields {
		Set pObject.CurrencyPair = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(44), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(44), .tTopPiece)
	If pGetTopFields {
		Set pObject.TransactionType = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(44), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(44), .tTopPiece)
	If pGetTopFields {
		Set pObject.Direction = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(44), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(44), .tTopPiece)
	If pGetTopFields {
		Set pObject.Quantity = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(44), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(44), .tTopPiece)
	If pGetTopFields {
		Set pObject.ExecutionRate =  pObject.ExecutionRateDisplayToLogical(tCurrString)
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(44), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(44), .tTopPiece)
	If pGetTopFields {
		Set pObject.ProfitLoss =  pObject.ProfitLossDisplayToLogical(tCurrString)
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(44), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(44), .tTopPiece)
	If pGetTopFields {
		Set pObject.YenRate =  pObject.YenRateDisplayToLogical(tCurrString)
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(44), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(44), .tTopPiece)
	If pGetTopFields {
		Set pObject.ProfitLossYen = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(44), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(44), .tTopPiece)
	If pGetTopFields {
		Set pObject.OrderDateTime = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(44), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(44), .tTopPiece)
	If pGetTopFields {
		Set pObject.ExecutionDateTime = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(44), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(44), .tTopPiece)
	If pGetTopFields {
		Set pObject.Channel = tCurrString
	}
	Quit tStatus
}

/// Internal helper method to output object to a stream
ClassMethod PutRecord(pStream As %IO.DeviceStream, pObject As %RegisteredObject, pHasTopFields As %Boolean, ByRef pPadArray As %String) As %Status [ Internal, Private ]
{
	Set tStatus = $$$OK
	Do pStream.Write($select(pHasTopFields: ..Escape(pObject.ExecutionNoLogicalToDisplay(pObject.ExecutionNo), $lb($char(44)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(44) _ $select(pHasTopFields: ..Escape(pObject.CurrencyPair, $lb($char(44)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(44) _ $select(pHasTopFields: ..Escape(pObject.TransactionType, $lb($char(44)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(44) _ $select(pHasTopFields: ..Escape(pObject.Direction, $lb($char(44)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(44) _ $select(pHasTopFields: ..Escape(pObject.Quantity, $lb($char(44)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(44) _ $select(pHasTopFields: ..Escape(pObject.ExecutionRateLogicalToDisplay(pObject.ExecutionRate), $lb($char(44)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(44) _ $select(pHasTopFields: ..Escape(pObject.ProfitLossLogicalToDisplay(pObject.ProfitLoss), $lb($char(44)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(44) _ $select(pHasTopFields: ..Escape(pObject.YenRateLogicalToDisplay(pObject.YenRate), $lb($char(44)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(44) _ $select(pHasTopFields: ..Escape(pObject.ProfitLossYen, $lb($char(44)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(44) _ $select(pHasTopFields: ..Escape(pObject.OrderDateTime, $lb($char(44)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(44) _ $select(pHasTopFields: ..Escape(pObject.ExecutionDateTime, $lb($char(44)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(44) _ $select(pHasTopFields: ..Escape(pObject.Channel, $lb($char(44)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(10), 0, .tStatus)
	If $$$ISERR(tStatus) Quit tStatus
	Quit tStatus
}

ClassMethod GetGeneratedClasses(Output pClasses As %String) As %Status
{
	Kill pClasses
	Set pClasses("FX.Rakuten.Record")=""
	Set pClasses($classname())=""
	Quit $$$OK
}

ClassMethod getIdentifier() As %String [ CodeMode = expression ]
{
""
}

ClassMethod getType() As EnsLib.RecordMap.Model.DataType.RecordType [ CodeMode = expression ]
{
"delimited"
}

XData RecordMap [ XMLNamespace = "http://www.intersystems.com/Ensemble/RecordMap" ]
{
<Record xmlns="http://www.intersystems.com/Ensemble/RecordMap" name="FX.Rakuten" type="delimited" char_encoding="UTF-8" targetClassname="FX.Rakuten.Record" complexBatchManaged="0" padFromLeft="0" recordTerminator="\x0a" escaping="all" escapeSequence="&quot;" allowEarlyTerminator="0">
  <Separators>
    <Separator>,</Separator>
  </Separators>
  <Field name="ExecutionNo" required="0" ignored="0" datatype="%Integer" repeating="0">
  </Field>
  <Field name="CurrencyPair" required="0" ignored="0" datatype="%String" repeating="0">
  </Field>
  <Field name="TransactionType" required="0" ignored="0" datatype="%String" repeating="0">
  </Field>
  <Field name="Direction" required="0" ignored="0" datatype="%String" repeating="0">
  </Field>
  <Field name="Quantity" required="0" ignored="0" datatype="%String" repeating="0">
  </Field>
  <Field name="ExecutionRate" required="0" ignored="0" datatype="%Decimal" params="SCALE=5" repeating="0">
  </Field>
  <Field name="ProfitLoss" required="0" ignored="0" datatype="%Decimal" params="SCALE=5" repeating="0">
  </Field>
  <Field name="YenRate" required="0" ignored="0" datatype="%Decimal" params="SCALE=5" repeating="0">
  </Field>
  <Field name="ProfitLossYen" required="0" ignored="0" datatype="%String" repeating="0">
  </Field>
  <Field name="OrderDateTime" required="0" ignored="0" datatype="%String" repeating="0">
  </Field>
  <Field name="ExecutionDateTime" required="0" ignored="0" datatype="%String" repeating="0">
  </Field>
  <Field name="Channel" required="0" ignored="0" datatype="%String" repeating="0">
  </Field>
</Record>
}

}
