Class FX.DB.Trade Extends %Persistent
{

/*
FX履歴データの収集方法

M2J

CSVダウンロード
　成立履歴一覧を選び、期間を指定

　ダウンロードディレクトリーに成立履歴一覧_nnnn.csvというファイルができる(UTF-8 unix format)

スワップに関しては、csvで抽出する方法がない

カラム１	通貨ペア	USD/JPY
カラム２	方向		売, 買
カラム３	タイプ		決済, 新規
カラム４	ユニット数	1000
カラム５	価格		108.100		
カラム６	価格		108.100		
カラム７	価格		108.100
カラム８	損益		+218
カラム９	日付		"2019/10/01 20:19:28"
カラム１０	日付		"2019/10/01 20:19:28"
				


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

　カラム２	日付		02-01-2019 06:10:49
　カラム４	日付		02-01-2019 06:10:49
　カラム５　通貨ペア	USD/JPY （標準）
　カラム６	方向		BUY,SELL
　カラム７	単位		1（10000）
　カラム８	価格		109.402
　カラム９	価格		109.402
　カラム１１損益		"5,455"
　カラム１２スワップ	-4745.00


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
 
 カラム１　日付　yyyy/mm/dd
 カラム４　""付きスワップ金額
 カラム５　日付　yyyy/mm/dd hh:mm
 カラム６　"約定No.1438      : ポンド/円       買 [約定レート]146.500 [建玉数量]3,000"
 

約定情報

照会（R)>約定照会
　注文区分　決済
約定日の範囲を指定
検索ボタンを押した後、保存ボタンを押す。
ファイル名を聞かれるので、ファイル名(rakuten.csv)を入力
SJISをUTF-8に変えて保存 unix format
最終行（空白行）を削除する
quote Escaping（一度Quoteなしにして生成し、その後QuotingでQuote Allを選択）

カラム２	通貨ペア　"ユーロ/ドル"
カラム４　　方向		"買","売"
カラム５　　ユニット数	"5,000"
カラム６	決済価格	"1.08906"　
カラム７	損益		"19.70"
カラム８	円レート	"108.020"　
カラム９	損益（円）	"2,127"
カラム１０	日付		"yyyy/mm/dd hh:mm"
カラム１１	日付		"yyyy/mm/dd hh:mm"



外為オンライン

レポート印刷

約定取引明細
取引区分　決済のみ
期間指定
データ出力ボタンを押す

YakujouTorihikiReort.csvというファイルができる。
SJISをUTF-8に変えて保存(Unix Format)

カラム２	日付		19-10-01 23:58
カラム５	通貨ペア	USD/JPY
カラム７	単位		1（1000）
カラム８	決済価格	108.1200
カラム９	手数料		20
カラム１１	損益	　　-1000
カラム１２	スワップ	-7	
	
	
*/
Property Broker As %String;

Property OpenDate As %Date;

Property CloseDate As %Date;

Property CurrencyPair As %String;

Property BuySell As %String;

Property TransactionUnit As %Integer;

Property OpenPrice As %Decimal(SCALE = 5);

Property ClosePrice As %Decimal(SCALE = 5);

Property ProfitLoss As %Integer;

Property Swap As %Integer;

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
<Value name="12">
<Value>Swap</Value>
</Value>
</Data>
<DataLocation>^FX.DB.TradeD</DataLocation>
<DefaultData>TradeDefaultData</DefaultData>
<IdLocation>^FX.DB.TradeD</IdLocation>
<IndexLocation>^FX.DB.TradeI</IndexLocation>
<StreamLocation>^FX.DB.TradeS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
