Class FX.Trade Extends %Persistent
{

/*
FX履歴データの収集方法

M2J

CSVダウンロード
　成立履歴一覧を選び、期間を指定

　ダウンロードディレクトリーに成立履歴一覧_nnnn.csvというファイルができる(UTF-8 unix format)

スワップに関しては、成立したものの累計を計上する。
保持したポジションの日々のスワップを抽出する方法が見つからないためとりあえずこの値を取得する。
従って正確なデータではない

IG

ライブ口座
　直近履歴
　さらに詳しい履歴はこちらをクリック　のところをクリック
　表示項目から損益明細を選択
　ポジションの詳細を確認する　決済を選択
　カスタム期間を指定して履歴のダウンロードボタンを押す

　TradeBreakDown-*.csvというファイルができる。(UTF-8, unix format)
　数字項目に,が入っている
　先頭複数行を削除
　Quote Escaping

楽天証券

スワップ
入出金・振替
　証拠金履歴
　取引タイプでスワップを選ぶ
　受渡日の範囲を指定して表示ボタンを押す。
　CSV形式で保存 ボタンを押す。(SJISなのでUTF-8に変換する
 unix format

　paymenthist_nnn.csvというファイルができる。
 最終行（空白行）を削除する
 Quote Escaping（一度Quoteなしにして生成し、その後QuotingでQuote Allを選択）

約定情報

照会（R)>約定照会
　注文区分　決済
約定日の範囲を指定
検索ボタンを押した後、保存ボタンを押す。
ファイル名を聞かれるので、ファイル名(rakuten.csv)を入力
SJISをUTF-8に変えて保存 unix format
最終行（空白行）を削除する
quote Escaping（一度Quoteなしにして生成し、その後QuotingでQuote Allを選択）

外為オンライン

レポート印刷

約定取引明細
取引区分　決済のみ
期間指定
データ出力ボタンを押す

YakujouTorihikiReort.csvというファイルができる。
SJISをUTF-8に変えて保存(Unix Format)

*/
Property Broker As %String;

Property OpenDate As %Date;

Property CloseDate As %Date;

Property CurrencyPair As %String;

Property BuySell As %String;

Property TransactionUnit As %Integer;

Property OpenPrice As %Numeric(SCALE = 5);

Property ClosePrice As %Numeric(SCALE = 5);

Property ProfitLoss As %Numeric(SCALE = 2);

Property FundingCost As %Numeric(SCALE = 2);

ClassMethod LoadIGData(pFileName As %String) As %Status
{
	set status = $$$OK
	
	set stream = ##class(%FileCharacterStream).%New()
	set tab = $char(9)
	set century = $extract($zdate($h,8),1,2)
	set stream.TranslateTable = "UTF8"
	set stream.Filename = pFileName
	While 'stream.AtEnd {
	set line = stream.ReadLine()
	If $extract(line,1,4)="取引種別" continue
	set transactiontype = $piece(line,tab,1)
	set closedate = $piece(line,tab,3)
	set closedate = $zdateh($translate(century_closedate,"/","-"),3)
	set profitloss = 0
	set fundingcost = 0
	set openprice = 0
	set closeprice = 0

	if transactiontype = "DEAL" {
	  set openprice = $piece(line,tab,7)
	  set closeprice = $piece(line,tab,10)
	  set pair = $translate($extract($piece(line,tab,5),1,7),"/","")
	  set unit = $piece(line,tab,9) * 10000
	  set profitloss = $piece(line,tab,11)

	  if unit < 0 {
		 set buysell = "SELL"
	  }
	  else {
		 set buysell = "BUY"
	  }
	}
	
	elseif (transactiontype = "WITH") || (transactiontype = "DEPO") {
	  set pair = $translate($piece($piece(line,tab,5)," ",7),"/","")
	  if $length(pair)'=6 set pair = $translate($extract($piece(line,tab,5),1,7),"/","") 	
	  set fundingcost = $piece(line,tab,11)
	  set unit = 0
	}
		
	Set ft = ..%New()
	Set ft.Broker = "IG"
	Set ft.BuySell = $get(buysell)
	Set ft.CurrencyPair = $replace(pair,"Funding","Adjust")
	Set ft.OpenPrice = +$get(openprice)
	Set ft.ClosePrice = +$get(closeprice)
	Set ft.CloseDate = closedate
	Set ft.ProfitLoss = profitloss
	Set ft.FundingCost = fundingcost
	Set ft.TransactionUnit = unit
	Set status = ft.%Save()
	If 'status Write $system.Status.DisplayError(status),!
	}
	Quit status
}

ClassMethod LoadM2JData(pFileName As %String) As %Status
{
	set status = $$$OK

	Set stream = ##class(%FileCharacterStream).%New()
	set tab = ","
	set stream.TranslateTable = "UTF8"
	Set stream.Filename = pFileName
	While 'stream.AtEnd {
	  Set line = stream.ReadLine()
	  If $extract(line,1,4)="注文番号" continue
	  set ordertype = $piece(line,tab,6)
	
	  Set closedate = $piece($piece(line,tab,2)," ",1)
	  set closedate = $zdateh($translate(closedate,"/","-"),3)
	  Set opendate = $piece($piece(line,tab,14)," ",1)
	  if opendate'="" {
	    set opendate = $zdateh($translate(opendate,"/","-"),3)
	  }
	  else {
		  set opendate = closedate
	  }
	  set pair = $translate($extract($piece(line,tab,4),1,7),"/","")
	  set buysell = $piece(line,tab,7)
	  set unit = $piece(line,tab,12)
	  set closeprice = $piece(line,tab,11)
	  set fundingcost = +$piece(line,tab,13)

	  if ordertype = "決済" {
	    set openprice = $piece(line,tab,15)
	    set profitloss = $piece(line,tab,16)
	    set buysell = $select(buysell="買":"SELL",buysell="売":"BUY",1:"")
	  } else {
	    set profitloss = 0
	    set openprice = closeprice	
	    set buysell = $select(buysell="買":"BUY",buysell="売":"SELL",1:"")
	  }
	
	  Set ft = ..%New()
	  Set ft.Broker = "M2J"
	  Set ft.BuySell = buysell
	  Set ft.CurrencyPair = pair
	  Set ft.OpenPrice = openprice
	  Set ft.ClosePrice = closeprice
	  Set ft.OpenDate = opendate
	  Set ft.CloseDate = closedate
	  Set ft.ProfitLoss = profitloss
	  Set ft.FundingCost = +fundingcost
	  Set ft.TransactionUnit = unit
	  Set status = ft.%Save()
	  If 'status Write $system.Status.DisplayError(status),!
	
    }
  
  Quit status
}

ClassMethod LoadRakutenData(pFileName As %String) As %Status
{
	set status = $$$OK

	Set stream = ##class(%FileCharacterStream).%New()
	set tab = $char(9)
	set stream.TranslateTable = "UTF8"
	Set stream.Filename = pFileName
	While 'stream.AtEnd {
	Set line = stream.ReadLine()
	If $extract(line,1,2)="約定" continue
	//ダブルクオートを取り除く
	set line = $translate(line,"""","") 
	set ordertype = $piece(line,tab,3)
	
	if ordertype = "決済" {
	  set closedate = $piece($piece(line,tab,11)," ",1)
	  set closedate = $zdateh($translate(closedate,"/","-"),3)
	  set opendate = $piece($piece(line,tab,10)," ",1)
	  set opendate = $zdateh($translate(opendate,"/","-"),3)
	  set pair = $translate($extract($piece(line,tab,2),1,7),"/","")
	  set pair = $replace(pair,"ユーロ","EUR")
	  set pair = $replace(pair,"豪ドル","AUD")	  
	  set pair = $replace(pair,"NZドル","NZD")	  
	  set pair = $replace(pair,"ドル","USD")
	  set pair = $replace(pair,"円","JPY")	  
	  set pair = $replace(pair,"ポンド","GBP")	  
	  set buysell = $piece(line,tab,4)
	  set buysell = $select(buysell="買":"SELL",buysell="売":"BUY",1:"")
	  set unit = $number($piece(line,tab,5))*1000
	  set closeprice = $number($piece(line,tab,6))
	  set profitloss = $number($piece(line,tab,9))
	  set pl = $piece(line,tab,7)/unit
	  
	  if buysell = "BUY" {
	     set openprice = closeprice - pl
	  } 
	  elseif buysell = "SELL" {
	     set openprice = closeprice + pl
	  }
	  
	  set fundingcost = 0
	
	  Set ft = ..%New()
	  Set ft.Broker = "Rakuten"
	  Set ft.BuySell = buysell
	  Set ft.CurrencyPair = pair
	  Set ft.OpenPrice = openprice
	  Set ft.ClosePrice = closeprice
	  Set ft.OpenDate = opendate
	  Set ft.CloseDate = closedate
	  Set ft.ProfitLoss = profitloss
	  Set ft.FundingCost = fundingcost
	  Set ft.TransactionUnit = unit
	  Set status = ft.%Save()
	  If 'status Write $system.Status.DisplayError(status),!
	}
  }
  Quit status
}

ClassMethod LoadRakutenSwapData(pFileName As %String) As %Status
{
	set status = $$$OK

	set tab = $char(9)
	Set stream = ##class(%FileCharacterStream).%New()
	set stream.TranslateTable = "UTF8"
	Set stream.Filename = pFileName
	While 'stream.AtEnd {
	Set line = stream.ReadLine()
	If $extract(line,1,2)="受渡" continue
	//ダブルクオートを取り除く
	set line = $translate(line,"""","") 
	set ordertype = $piece(line,tab,2)
	
	if ordertype = "スワップ" {
	  Set closedate = $piece(line,tab,1)
	  set closedate = $zdateh($translate(closedate,"/","-"),3)
	  Set opendate = $piece($piece(line,tab,5)," ",1)
	  set opendate = $zdateh($translate(opendate,"/","-"),3)
	  set others = $piece(line,tab,6)
	  set pair = $translate($piece($piece(others,":",2)," ",2),"/","")
	  set pair = $replace(pair,"ユーロ","EUR")
	  set pair = $replace(pair,"豪ドル","AUD")	  
	  set pair = $replace(pair,"NZドル","NZD")	  
	  set pair = $replace(pair,"ドル","USD")
	  set pair = $replace(pair,"円","JPY")	  
	  set pair = $replace(pair,"ポンド","GBP")
	  set buysell = $extract($reverse($piece($piece(others,":",2),"[約定レート]",1)),2)
	  set buysell = $select(buysell="売":"SELL",buysell="買":"BUY",1:"")
	  set unit = $number($piece($piece(others,":",2),"[建玉数量]",2))*1000
	  set openprice = +$piece($piece($piece(others,":",2),"[約定レート]",2),"[建玉数量]",1)
	  set closeprice = openprice
	  set profitloss = 0
	  set fundingcost =$number($translate($piece(line,tab,4),"""",""))
	
	  Set ft = ..%New()
	  Set ft.Broker = "Rakuten"
	  Set ft.BuySell = buysell
	  Set ft.CurrencyPair = pair
	  Set ft.OpenPrice = openprice
	  Set ft.ClosePrice = closeprice
	  Set ft.OpenDate = opendate
	  Set ft.CloseDate = closedate
	  Set ft.ProfitLoss = profitloss
	  Set ft.FundingCost = fundingcost
	  Set ft.TransactionUnit = unit
	  Set status = ft.%Save()
	  If 'status Write $system.Status.DisplayError(status),!
	}
  }
  Quit status
}

Storage Default
{
<Data name="TradeDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Broker</Value>
</Value>
<Value name="3">
<Value>OpenDate</Value>
</Value>
<Value name="4">
<Value>CloseDate</Value>
</Value>
<Value name="5">
<Value>CurrencyPair</Value>
</Value>
<Value name="6">
<Value>BuySell</Value>
</Value>
<Value name="7">
<Value>TransactionUnit</Value>
</Value>
<Value name="8">
<Value>OpenPrice</Value>
</Value>
<Value name="9">
<Value>ClosePrice</Value>
</Value>
<Value name="10">
<Value>ProfitLoss</Value>
</Value>
<Value name="11">
<Value>FundingCost</Value>
</Value>
</Data>
<DataLocation>^FX.TradeD</DataLocation>
<DefaultData>TradeDefaultData</DefaultData>
<IdLocation>^FX.TradeD</IdLocation>
<IndexLocation>^FX.TradeI</IndexLocation>
<StreamLocation>^FX.TradeS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
