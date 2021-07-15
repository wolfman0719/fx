Class FX.LoadTransaction Extends Ens.Production
{

XData ProductionDefinition
{
<Production Name="FX.LoadTransaction" LogGeneralTraceEvents="false">
  <Description></Description>
  <ActorPoolSize>2</ActorPoolSize>
  <Item Name="LoadIGSecurity" Category="" ClassName="EnsLib.RecordMap.Service.FileService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Host" Name="RecordMap">FX.IGSecurity</Setting>
    <Setting Target="Adapter" Name="ArchivePath">/intersystems/iris/fx/arc</Setting>
    <Setting Target="Adapter" Name="Charset">utf-8</Setting>
    <Setting Target="Adapter" Name="FilePath">/intersystems/iris/fx/in</Setting>
    <Setting Target="Adapter" Name="FileSpec">Trade*</Setting>
    <Setting Target="Adapter" Name="WorkPath">/intersystems/iris/fx/work</Setting>
    <Setting Target="Host" Name="TargetConfigNames">BuildDB</Setting>
  </Item>
  <Item Name="LoadM2J" Category="" ClassName="EnsLib.RecordMap.Service.FileService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Host" Name="RecordMap">FX.M2J</Setting>
    <Setting Target="Adapter" Name="ArchivePath">/intersystems/iris/fx/arc</Setting>
    <Setting Target="Adapter" Name="Charset">utf-8</Setting>
    <Setting Target="Adapter" Name="FilePath">/intersystems/iris/fx/in</Setting>
    <Setting Target="Adapter" Name="FileSpec">m2j*</Setting>
    <Setting Target="Adapter" Name="WorkPath">/intersystems/iris/fx/work</Setting>
    <Setting Target="Host" Name="TargetConfigNames">BuildDB</Setting>
  </Item>
  <Item Name="LoadRakuten" Category="" ClassName="EnsLib.RecordMap.Service.FileService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="RecordMap">FX.Rakuten</Setting>
    <Setting Target="Adapter" Name="ArchivePath">/intersystems/iris/fx/arc</Setting>
    <Setting Target="Adapter" Name="Charset">utf-8</Setting>
    <Setting Target="Adapter" Name="FilePath">/intersystems/iris/fx/in</Setting>
    <Setting Target="Adapter" Name="FileSpec">rakuten*</Setting>
    <Setting Target="Adapter" Name="WorkPath">/intersystems/iris/fx/work</Setting>
    <Setting Target="Host" Name="TargetConfigNames">BuildDB</Setting>
  </Item>
  <Item Name="LoadRakutenSwap" Category="" ClassName="EnsLib.RecordMap.Service.FileService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Host" Name="RecordMap">FX.RakutenSwap</Setting>
    <Setting Target="Adapter" Name="ArchivePath">/intersystems/iris/fx/arc</Setting>
    <Setting Target="Adapter" Name="Charset">utf-8</Setting>
    <Setting Target="Adapter" Name="FilePath">/intersystems/iris/fx/in</Setting>
    <Setting Target="Adapter" Name="FileSpec">payment*</Setting>
    <Setting Target="Adapter" Name="WorkPath">/intersystems/iris/fx/work</Setting>
    <Setting Target="Host" Name="TargetConfigNames">BuildDB</Setting>
  </Item>
  <Item Name="LoadGaitameOnline" Category="" ClassName="EnsLib.RecordMap.Service.FileService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Host" Name="RecordMap">FX.GaitameOnline</Setting>
    <Setting Target="Adapter" Name="ArchivePath">/intersystems/iris/fx/arc</Setting>
    <Setting Target="Adapter" Name="Charset">utf-8</Setting>
    <Setting Target="Adapter" Name="FilePath">/intersystems/iris/fx/in</Setting>
    <Setting Target="Adapter" Name="FileSpec">Yakujou*</Setting>
    <Setting Target="Adapter" Name="WorkPath">/intersystems/iris/fx/work</Setting>
    <Setting Target="Host" Name="TargetConfigNames">BuildDB</Setting>
  </Item>
  <Item Name="FX Data Load" Category="" ClassName="FX.Operation.RecordInsert" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="BuildDB" Category="" ClassName="FX.BP.BuildDB" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
  </Item>
</Production>
}

}
