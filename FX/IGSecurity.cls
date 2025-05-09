/// RECORDMAP: Modified during compilation of RecordMap 'FX.IGSecurity'
/// on 2019-10-18 at 15:38:16.453 [2019-10-18 06:38:16.453 UTC]
/// by user UnknownUser
Class FX.IGSecurity Extends EnsLib.RecordMap.RecordMap
{

Parameter OBJECTNAME = "FX.IGSecurity.Record";

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
    Set pObject.ClosingRef = tCurrString
  }
  If '$data(tRecordData(tCurrChunk, "block")) {
    Set tCurrString = $piece(tRecordData(tCurrChunk), $char(44), tTopPiece)
  }
  Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(44), .tTopPiece)
  If pGetTopFields {
    Set pObject.ClosedDateTime = tCurrString
  }
  If '$data(tRecordData(tCurrChunk, "block")) {
    Set tCurrString = $piece(tRecordData(tCurrChunk), $char(44), tTopPiece)
  }
  Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(44), .tTopPiece)
  If pGetTopFields {
    Set pObject.OpeningRef = tCurrString
  }
  If '$data(tRecordData(tCurrChunk, "block")) {
    Set tCurrString = $piece(tRecordData(tCurrChunk), $char(44), tTopPiece)
  }
  Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(44), .tTopPiece)
  If pGetTopFields {
    Set pObject.OpendDateTime = tCurrString
  }
  If '$data(tRecordData(tCurrChunk, "block")) {
    Set tCurrString = $piece(tRecordData(tCurrChunk), $char(44), tTopPiece)
  }
  Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(44), .tTopPiece)
  If pGetTopFields {
    Set pObject.Market = tCurrString
  }
  If '$data(tRecordData(tCurrChunk, "block")) {
    Set tCurrString = $piece(tRecordData(tCurrChunk), $char(44), tTopPiece)
  }
  Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(44), .tTopPiece)
  If pGetTopFields {
    Set pObject.Period = tCurrString
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
    Set pObject.Size =  pObject.SizeDisplayToLogical(tCurrString)
  }
  If '$data(tRecordData(tCurrChunk, "block")) {
    Set tCurrString = $piece(tRecordData(tCurrChunk), $char(44), tTopPiece)
  }
  Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(44), .tTopPiece)
  If pGetTopFields {
    Set pObject.Opening =  pObject.OpeningDisplayToLogical(tCurrString)
  }
  If '$data(tRecordData(tCurrChunk, "block")) {
    Set tCurrString = $piece(tRecordData(tCurrChunk), $char(44), tTopPiece)
  }
  Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(44), .tTopPiece)
  If pGetTopFields {
    Set pObject.Closing =  pObject.ClosingDisplayToLogical(tCurrString)
  }
  If '$data(tRecordData(tCurrChunk, "block")) {
    Set tCurrString = $piece(tRecordData(tCurrChunk), $char(44), tTopPiece)
  }
  Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(44), .tTopPiece)
  If pGetTopFields {
    Set pObject.TradeCurrency = tCurrString
  }
  If '$data(tRecordData(tCurrChunk, "block")) {
    Set tCurrString = $piece(tRecordData(tCurrChunk), $char(44), tTopPiece)
  }
  Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(44), .tTopPiece)
  If pGetTopFields {
    Set pObject.ProfitLoss = tCurrString
  }
  If '$data(tRecordData(tCurrChunk, "block")) {
    Set tCurrString = $piece(tRecordData(tCurrChunk), $char(44), tTopPiece)
  }
  Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(44), .tTopPiece)
  If pGetTopFields {
    Set pObject.Funding =  pObject.FundingDisplayToLogical(tCurrString)
  }
  If '$data(tRecordData(tCurrChunk, "block")) {
    Set tCurrString = $piece(tRecordData(tCurrChunk), $char(44), tTopPiece)
  }
  Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(44), .tTopPiece)
  If pGetTopFields {
    Set pObject.Borrowing =  pObject.BorrowingDisplayToLogical(tCurrString)
  }
  If '$data(tRecordData(tCurrChunk, "block")) {
    Set tCurrString = $piece(tRecordData(tCurrChunk), $char(44), tTopPiece)
  }
  Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(44), .tTopPiece)
  If pGetTopFields {
    Set pObject.Dividends =  pObject.DividendsDisplayToLogical(tCurrString)
  }
  If '$data(tRecordData(tCurrChunk, "block")) {
    Set tCurrString = $piece(tRecordData(tCurrChunk), $char(44), tTopPiece)
  }
  Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(44), .tTopPiece)
  If pGetTopFields {
    Set pObject.LRPrem =  pObject.LRPremDisplayToLogical(tCurrString)
  }
  If '$data(tRecordData(tCurrChunk, "block")) {
    Set tCurrString = $piece(tRecordData(tCurrChunk), $char(44), tTopPiece)
  }
  Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(44), .tTopPiece)
  If pGetTopFields {
    Set pObject.Others =  pObject.OthersDisplayToLogical(tCurrString)
  }
  If '$data(tRecordData(tCurrChunk, "block")) {
    Set tCurrString = $piece(tRecordData(tCurrChunk), $char(44), tTopPiece)
  }
  Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(44), .tTopPiece)
  If pGetTopFields {
    Set pObject.CommCurrency = tCurrString
  }
  If '$data(tRecordData(tCurrChunk, "block")) {
    Set tCurrString = $piece(tRecordData(tCurrChunk), $char(44), tTopPiece)
  }
  Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(44), .tTopPiece)
  If pGetTopFields {
    Set pObject.Comm =  pObject.CommDisplayToLogical(tCurrString)
  }
  If '$data(tRecordData(tCurrChunk, "block")) {
    Set tCurrString = $piece(tRecordData(tCurrChunk), $char(44), tTopPiece)
  }
  Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(44), .tTopPiece)
  If pGetTopFields {
   Set pObject.Total = tCurrString
  }
  Quit tStatus
}

/// Internal helper method to output object to a stream
ClassMethod PutRecord(pStream As %IO.DeviceStream, pObject As %RegisteredObject, pHasTopFields As %Boolean, ByRef pPadArray As %String) As %Status [ Internal, Private ]
{
  Set tStatus = $$$OK
  Do pStream.Write($select(pHasTopFields: ..Escape(pObject.ClosingRef, $lb($char(44)),"quote",$char(34)),1: ""),0)
  Do pStream.Write($char(44) _ $select(pHasTopFields: ..Escape(pObject.ClosedDateTime, $lb($char(44)),"quote",$char(34)),1: ""),0)
  Do pStream.Write($char(44) _ $select(pHasTopFields: ..Escape(pObject.OpeningRef, $lb($char(44)),"quote",$char(34)),1: ""),0)
  Do pStream.Write($char(44) _ $select(pHasTopFields: ..Escape(pObject.OpendDateTime, $lb($char(44)),"quote",$char(34)),1: ""),0)
  Do pStream.Write($char(44) _ $select(pHasTopFields: ..Escape(pObject.Market, $lb($char(44)),"quote",$char(34)),1: ""),0)
  Do pStream.Write($char(44) _ $select(pHasTopFields: ..Escape(pObject.Period, $lb($char(44)),"quote",$char(34)),1: ""),0)
  Do pStream.Write($char(44) _ $select(pHasTopFields: ..Escape(pObject.Direction, $lb($char(44)),"quote",$char(34)),1: ""),0)
  Do pStream.Write($char(44) _ $select(pHasTopFields: ..Escape(pObject.SizeLogicalToDisplay(pObject.Size), $lb($char(44)),"quote",$char(34)),1: ""),0)
  Do pStream.Write($char(44) _ $select(pHasTopFields: ..Escape(pObject.OpeningLogicalToDisplay(pObject.Opening), $lb($char(44)),"quote",$char(34)),1: ""),0)
  Do pStream.Write($char(44) _ $select(pHasTopFields: ..Escape(pObject.ClosingLogicalToDisplay(pObject.Closing), $lb($char(44)),"quote",$char(34)),1: ""),0)
  Do pStream.Write($char(44) _ $select(pHasTopFields: ..Escape(pObject.TradeCurrency, $lb($char(44)),"quote",$char(34)),1: ""),0)
  Do pStream.Write($char(44) _ $select(pHasTopFields: ..Escape(pObject.ProfitLoss, $lb($char(44)),"quote",$char(34)),1: ""),0)
  Do pStream.Write($char(44) _ $select(pHasTopFields: ..Escape(pObject.FundingLogicalToDisplay(pObject.Funding), $lb($char(44)),"quote",$char(34)),1: ""),0)
  Do pStream.Write($char(44) _ $select(pHasTopFields: ..Escape(pObject.BorrowingLogicalToDisplay(pObject.Borrowing), $lb($char(44)),"quote",$char(34)),1: ""),0)
  Do pStream.Write($char(44) _ $select(pHasTopFields: ..Escape(pObject.DividendsLogicalToDisplay(pObject.Dividends), $lb($char(44)),"quote",$char(34)),1: ""),0)
  Do pStream.Write($char(44) _ $select(pHasTopFields: ..Escape(pObject.LRPremLogicalToDisplay(pObject.LRPrem), $lb($char(44)),"quote",$char(34)),1: ""),0)
  Do pStream.Write($char(44) _ $select(pHasTopFields: ..Escape(pObject.OthersLogicalToDisplay(pObject.Others), $lb($char(44)),"quote",$char(34)),1: ""),0)
  Do pStream.Write($char(44) _ $select(pHasTopFields: ..Escape(pObject.CommCurrency, $lb($char(44)),"quote",$char(34)),1: ""),0)
  Do pStream.Write($char(44) _ $select(pHasTopFields: ..Escape(pObject.CommLogicalToDisplay(pObject.Comm), $lb($char(44)),"quote",$char(34)),1: ""),0)
  Do pStream.Write($char(44) _ $select(pHasTopFields: ..Escape(pObject.Total, $lb($char(44)),"quote",$char(34)),1: ""),0)
  Do pStream.Write($char(10), 0, .tStatus)
  If $$$ISERR(tStatus) Quit tStatus
  Quit tStatus
}

ClassMethod GetGeneratedClasses(Output pClasses As %String) As %Status
{
  Kill pClasses
  Set pClasses("FX.IGSecurity.Record")=""
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
<Record xmlns="http://www.intersystems.com/Ensemble/RecordMap" name="FX.IGSecurity" type="delimited" char_encoding="UTF-8" targetClassname="FX.IGSecurity.Record" complexBatchManaged="0" padFromLeft="0" recordTerminator="\x0a" escaping="quote" escapeSequence="&quot;" allowEarlyTerminator="0">
  <Separators>
    <Separator>,</Separator>
  </Separators>
  <Field name="ClosingRef" required="0" ignored="0" datatype="%String" repeating="0">
  </Field>
  <Field name="ClosedDateTime" required="0" ignored="0" datatype="%String" repeating="0">
  </Field>
  <Field name="OpeningRef" required="0" ignored="0" datatype="%String" repeating="0">
  </Field>
  <Field name="OpendDateTime" required="0" ignored="0" datatype="%String" repeating="0">
  </Field>
  <Field name="Market" required="0" ignored="0" datatype="%String" repeating="0">
  </Field>
  <Field name="Period" required="0" ignored="0" datatype="%String" repeating="0">
  </Field>
  <Field name="Direction" required="0" ignored="0" datatype="%String" repeating="0">
  </Field>
  <Field name="Size" required="0" ignored="0" datatype="%Integer" repeating="0">
  </Field>
  <Field name="Opening" required="0" ignored="0" datatype="%Decimal" params="SCALE=5" repeating="0">
  </Field>
  <Field name="Closing" required="0" ignored="0" datatype="%Decimal" params="SCALE=5" repeating="0">
  </Field>
  <Field name="TradeCurrency" required="0" ignored="0" datatype="%String" repeating="0">
  </Field>
  <Field name="ProfitLoss" required="0" ignored="0" datatype="%String" repeating="0">
  </Field>
  <Field name="Funding" required="0" ignored="0" datatype="%Decimal" params="SCALE=2" repeating="0">
  </Field>
  <Field name="Borrowing" required="0" ignored="0" datatype="%Decimal" params="SCALE=2" repeating="0">
  </Field>
  <Field name="Dividends" required="0" ignored="0" datatype="%Decimal" params="SCALE=2" repeating="0">
  </Field>
  <Field name="LRPrem" required="0" ignored="0" datatype="%Decimal" params="SCALE=2" repeating="0">
  </Field>
  <Field name="Others" required="0" ignored="0" datatype="%Decimal" params="SCALE=2" repeating="0">
  </Field>
  <Field name="CommCurrency" required="0" ignored="0" datatype="%String" repeating="0">
  </Field>
  <Field name="Comm" required="0" ignored="0" datatype="%Decimal" params="SCALE=2" repeating="0">
  </Field>
  <Field name="Total" required="0" ignored="0" datatype="%String" repeating="0">
  </Field>
</Record>
}

}
