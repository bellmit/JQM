--综合信息查询-产品持仓明细-债券摘牌日提醒查询-证券债券摘牌日与证券兑付日查询
select t1.f16_1090 zqdm, t1.f18_1090 zpr, t2.f41_1429 dqr
  from STAGE.WIND_TB_OBJECT_1090 t1, STAGE.WIND_TB_OBJECT_1429 t2
 where t1.f19_1090 <> 1
   and t1.f2_1090 = t2.f1_1429
   and instr(t1.ob_object_name_1090, '柜台') = 0
   --and t1.f16_1090 in('300344','112103','112124','112154','112162')    //证券代码
