package com.cjhxfund.ats.fm.comm;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.cjhxfund.commonUtil.CacheUtil;
import com.eos.foundation.eoscommon.LogUtil;
import com.eos.system.annotation.Bizlet;
import com.primeton.ext.engine.component.LogicComponentFactory;

/**
 * 日期公共类
 * @author huangmizhi
 */
@Bizlet("")
public class DateUtil {
	
	private static final Log log = LogFactory.getLog(DateUtil.class);

	/** 年月日模式字符串，如：20100101*/
	public static final String YMD_NUMBER = "yyyyMMdd";
	/** 年月日模式字符串，如：2010-01-01*/
	public static final String YEAR_MONTH_DAY_PATTERN = "yyyy-MM-dd";
	/** 时分秒模式字符串，如：13:01:01 */
	public static final String HOUR_MINUTE_SECOND_PATTERN = "HH:mm:ss";
	/** 年月日时分秒模式字符串，如： 20100101130101 */
	public static final String YYYYMMDDHHMMSS_NUMBER = "yyyyMMddHHmmss";
	/** 年月日时分秒毫秒模式字符串，如： 20100101130101001 */
	public static final String YYYYMMDDHHMMSSS_NUMBER = "yyyyMMddHHmmssS";
	/** 年月日时分秒模式字符串，如： 2010-01-01 13:01:01 */
	public static final String YMDHMS_PATTERN = "yyyy-MM-dd HH:mm:ss";
	/** 年月日时分秒模式字符串，如： 20100101-13:01:01 */
	public static final String YMD_HMS_PATTERN = "yyyyMMdd-HH:mm:ss";
	
	public static final int[] Calendar_FIELDS = new int[] { Calendar.YEAR,
			Calendar.MONTH, Calendar.DAY_OF_MONTH, Calendar.HOUR_OF_DAY,
			Calendar.MINUTE, Calendar.SECOND, Calendar.MILLISECOND };

	public DateUtil() {
	}

	/**
	 * 计算当前和指定月份之间的字符串
	 * @param anMonth 间隔月份
	 * @return String
	 */
	@Bizlet("")
	public static String addMonthStr(int anMonth) {
		Calendar c = Calendar.getInstance();
		c.add(Calendar.MONTH, anMonth);
		return Integer.toString(c.get(Calendar.YEAR)) + "-"
				+ Integer.toString(c.get(Calendar.MONTH)) + "-"
				+ Integer.toString(c.get(Calendar.DAY_OF_MONTH));
	}

	/**
	 * 计算指定日期和指定月份之间的字符串
	 * @param date 指定日期
	 * @param anMonth 间隔月份
	 * @return
	 */
	@Bizlet("")
	public static String addMonthStr(Date date, int anMonth) {
		Calendar c = Calendar.getInstance();
		c.setTime(date);
		c.add(Calendar.MONTH, anMonth);
		return Integer.toString(c.get(Calendar.YEAR)) + "-"
				+ Integer.toString(c.get(Calendar.MONTH)) + "-"
				+ Integer.toString(c.get(Calendar.DAY_OF_MONTH));
	}

	/**
	 * 获取当前时间（java.sql.Date类型）
	 * @return 返回当前时间
	 * @throws SQLException 获取数据库时间时发生错误
	 */
	@Bizlet("")
	public static Date currentDate() {
		return new Date(System.currentTimeMillis());
	}

	/**
	 * 获取当前时间
	 * @return
	 */
	@Bizlet("")
	public static java.sql.Timestamp currentTimestamp() {
		return new java.sql.Timestamp(System.currentTimeMillis());
	}

	/**
	 * 获取当前时间（java.sql.Date类型）
	 * @return
	 */
	@Bizlet("")
	public static java.sql.Date currentSQLDate() {
		return new java.sql.Date(System.currentTimeMillis());
	}

	/**
	 * 获取当前时间并根据传入的patter转换成字符串形式。
	 * @param pattern 日期格式
	 * @return 返回当前时间根据传入pattern转换后的字符串
	 * @throws SQLException 获取数据库时间时发生错误
	 */
	@Bizlet("")
	public static String currentDateString(final String pattern) {
		return format(currentDate(), pattern);
	}

	/**
	 * 获取当前时间并转换成默认字符串形式（yyyy-MM-dd HH:mm:ss）。
	 * @return 返回当前时间的默认字符串形式（yyyy-MM-dd HH:mm:ss）
	 * @throws SQLException 获取数据库时间时发生错误
	 */
	@Bizlet("")
	public static String currentDateTimeString() {
		return format(currentDate(), YMDHMS_PATTERN);
	}

	/**
	 * 获取当前时间并转换成默认字符串形式（yyyy-MM-dd）。
	 * @return 返回当前时间的默认字符串形式（yyyy-MM-dd）
	 * @throws SQLException 获取数据库时间时发生错误
	 */
	@Bizlet("")
	public static String currentDateDefaultString() {
		return format(currentDate(), YEAR_MONTH_DAY_PATTERN);
	}

	/**
	 * 获取给定日期对象的年
	 * @param date 日期对象
	 * @return 年
	 */
	@Bizlet("")
	public static int getYear(final Date date) {
		Calendar c = Calendar.getInstance();
		c.setTime(date);
		return c.get(Calendar.YEAR);
	}

	/**
	 * 获取给定日期对象的月
	 * @param date 日期对象
	 * @return 月
	 */
	@Bizlet("")
	public static int getMonth(final Date date) {
		Calendar c = Calendar.getInstance();
		c.setTime(date);
		return c.get(Calendar.MONTH) + 1;
	}

	/**
	 * 获取给定日期对象的天
	 * @param date 日期对象
	 * @return 天
	 */
	@Bizlet("")
	public static int getDay(final Date date) {
		Calendar c = Calendar.getInstance();
		c.setTime(date);
		return c.get(Calendar.DATE);
	}

	/**
	 * 获取给定日期对象的时
	 * @param date 日期对象
	 * @return 时
	 */
	@Bizlet("")
	public static int getHour(final Date date) {
		Calendar c = Calendar.getInstance();
		c.setTime(date);
		return c.get(Calendar.HOUR_OF_DAY);
	}

	/**
	 * 获取给定日期对象的分
	 * @param date 日期对象
	 * @return 分
	 */
	@Bizlet("")
	public static int getMinute(final Date date) {
		Calendar c = Calendar.getInstance();
		c.setTime(date);
		return c.get(Calendar.MINUTE);
	}

	/**
	 * 获取给定日期对象的秒
	 * @param date 日期对象
	 * @return 秒
	 */
	@Bizlet("")
	public static int getSecond(final Date date) {
		Calendar c = Calendar.getInstance();
		c.setTime(date);
		return c.get(Calendar.SECOND);
	}

	/**
	 * 获取传入日期的年和月的Integer形式（yyyyMM）。
	 * @param date 要转换的日期对象
	 * @return 转换后的Integer对象
	 */
	@Bizlet("")
	public static Integer getYearMonth(final Date date) {
		return new Integer(format(date, "yyyyMM"));
	}

	/**
	 * 将年月的整数形式（yyyyMM）转换为日期对象返回
	 * @param yearMonth 年月的整数形式（yyyyMM）
	 * @return 日期类型
	 * @throws ParseException
	 */
	@Bizlet("")
	public static Date parseYearMonth(final Integer yearMonth) {
		return parse(String.valueOf(yearMonth), "yyyyMM");
	}

	/**
	 * 将某个日期增加指定年数，并返回结果。如果传入负数，则为减。
	 * @param date 要操作的日期对象
	 * @param ammount 要增加年的数目
	 * @return 结果日期对象
	 */
	@Bizlet("")
	public static Date addYear(final Date date, final int ammount) {
		Calendar c = Calendar.getInstance();
		c.setTime(date);
		c.add(Calendar.YEAR, ammount);
		return c.getTime();
	}

	/**
	 * 将某个日期增加指定月数，并返回结果。如果传入负数，则为减。
	 * @param date 要操作的日期对象
	 * @param ammount 要增加月的数目
	 * @return 结果日期对象
	 */
	@Bizlet("")
	public static Date addMonth(final Date date, final int ammount) {
		Calendar c = Calendar.getInstance();
		c.setTime(date);
		c.add(Calendar.MONTH, ammount);
		return c.getTime();
	}

	/**
	 * 将某个日期增加指定天数，并返回结果。如果传入负数，则为减。
	 * @param date 要操作的日期对象
	 * @param ammount 要增加天的数目
	 * @return 结果日期对象
	 */
	@Bizlet("")
	public static Date addDay(final Date date, final int ammount) {
		Calendar c = Calendar.getInstance();
		c.setTime(date);
		c.add(Calendar.DATE, ammount);
		return c.getTime();
	}

	/**
	 * 将给定整数形式的年月增加指定月数，并返回结果。如果传入负数，则为减。
	 * @param yearMonth 要操作的年月
	 * @param ammount 要增加的月数
	 * @return 结果年月
	 * @throws ParseException
	 */
	@Bizlet("")
	public static Integer addMonth(final Integer yearMonth, final int ammount) throws ParseException {
		return getYearMonth(addMonth(parseYearMonth(yearMonth), ammount));
	}

	/**
	 * 返回给定的beforeDate比afterDate早的年数。如果beforeDate晚于afterDate，则 返回负数。
	 * @param beforeDate 要比较的早的日期
	 * @param afterDate 要比较的晚的日期
	 * @return beforeDate比afterDate早的年数，负数表示晚。
	 */
	@Bizlet("")
	public static int beforeYears(final Date beforeDate, final Date afterDate) {
		Calendar beforeCalendar = Calendar.getInstance();
		beforeCalendar.setTime(beforeDate);
		beforeCalendar.set(Calendar.MONTH, 1);
		beforeCalendar.set(Calendar.DATE, 1);
		beforeCalendar.set(Calendar.HOUR, 0);
		beforeCalendar.set(Calendar.SECOND, 0);
		beforeCalendar.set(Calendar.MINUTE, 0);
		Calendar afterCalendar = Calendar.getInstance();
		afterCalendar.setTime(afterDate);
		afterCalendar.set(Calendar.MONTH, 1);
		afterCalendar.set(Calendar.DATE, 1);
		afterCalendar.set(Calendar.HOUR, 0);
		afterCalendar.set(Calendar.SECOND, 0);
		afterCalendar.set(Calendar.MINUTE, 0);
		boolean positive = true;
		if (beforeDate.after(afterDate)) {
			positive = false;
		}
		int beforeYears = 0;
		while (true) {
			boolean yearEqual = beforeCalendar.get(Calendar.YEAR) == afterCalendar
					.get(Calendar.YEAR);
			if (yearEqual) {
				break;
			} else {
				if (positive) {
					beforeYears++;
					beforeCalendar.add(Calendar.YEAR, 1);
				} else {
					beforeYears--;
					beforeCalendar.add(Calendar.YEAR, -1);
				}
			}
		}
		if (log.isDebugEnabled()) {
			log.debug("超前时间是：" + Integer.toString(beforeYears));
		}
		return beforeYears;
	}

	/**
	 * 比较两个日期型的数据
	 * @param anStartPos 比较点
	 * @param firstDate 第一时间
	 * @param secondDate 第二时间
	 * @return 如果第一个日期大于第二个日期；则返回true；否则返回False
	 */
	@Bizlet("")
	public static boolean compareDate(int anStartPos, final Date firstDate,	final Date secondDate, boolean anEq) {
		if (firstDate == null)
			return false;
		if (secondDate == null)
			return true;

		Calendar firstC = Calendar.getInstance();
		firstC.setTime(firstDate);
		Calendar secondC = Calendar.getInstance();
		secondC.setTime(secondDate);

		for (int i = anStartPos, k = Calendar_FIELDS.length; i < k; i++) {
			int intFirst = firstC.get(Calendar_FIELDS[i]);
			int intSecond = secondC.get(Calendar_FIELDS[i]);
			if (anEq) {
				if (intFirst >= intSecond) {
					return true;
				} else if (intFirst <= intSecond) {
					return false;
				}
			} else {
				if (intFirst > intSecond) {
					return true;
				} else if (intFirst < intSecond) {
					return false;
				}
			}
		}
		return false;
	}

	public static boolean compareDate(Date firstDate, Date secondDate) {
		if ((firstDate == null) && (secondDate == null))
			return true;
		if (firstDate == null) {
			return false;
		}
		if (secondDate == null) {
			return true;
		}
		return firstDate.getTime() > secondDate.getTime();
	}

	public static boolean betweenYearWithEq(final Date firstDate, final Date anDate, final Date secondDate) {
		return compareDate(0, anDate, firstDate, true) && compareDate(0, secondDate, anDate, true);
	}

	public static boolean betweenYear(final Date firstDate, final Date anDate, final Date secondDate) {
		return compareDate(0, anDate, firstDate, false) && compareDate(0, secondDate, anDate, false);
	}

	public static boolean betweenMonthWithEq(final Date firstDate, final Date anDate, final Date secondDate) {
		return compareDate(1, anDate, firstDate, true) && compareDate(1, secondDate, anDate, true);
	}

	public static boolean betweenMonth(final Date firstDate, final Date anDate,	final Date secondDate) {
		return compareDate(1, anDate, firstDate, false) && compareDate(1, secondDate, anDate, false);
	}

	public static boolean betweenDayWithEq(final Date firstDate, final Date anDate, final Date secondDate) {
		return compareDate(2, anDate, firstDate, true) && compareDate(2, secondDate, anDate, true);
	}

	public static boolean betweenDay(final Date firstDate, final Date anDate, final Date secondDate) {
		return compareDate(2, anDate, firstDate, false) && compareDate(2, secondDate, anDate, false);
	}

	public static boolean betweenMonth(final Date firstDate, final int anMonth) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(firstDate);
		return calendar.get(Calendar.MONTH) == anMonth;
	}

	/**
	 * 返回给定的beforeDate比afterDate早的月数。如果beforeDate晚于afterDate，则 返回负数。
	 * @param beforeDate 要比较的早的日期
	 * @param afterDate 要比较的晚的日期
	 * @return beforeDate比afterDate早的月数，负数表示晚。
	 */
	@Bizlet("")
	public static int beforeMonths(final Date beforeDate, final Date afterDate) {
		Calendar beforeCalendar = Calendar.getInstance();
		beforeCalendar.setTime(beforeDate);
		beforeCalendar.set(Calendar.DATE, 1);
		beforeCalendar.set(Calendar.HOUR, 0);
		beforeCalendar.set(Calendar.SECOND, 0);
		beforeCalendar.set(Calendar.MINUTE, 0);
		Calendar afterCalendar = Calendar.getInstance();
		afterCalendar.setTime(afterDate);
		afterCalendar.set(Calendar.DATE, 1);
		afterCalendar.set(Calendar.HOUR, 0);
		afterCalendar.set(Calendar.SECOND, 0);
		afterCalendar.set(Calendar.MINUTE, 0);
		boolean positive = true;
		if (beforeDate.after(afterDate)) {
			positive = false;
		}
		int beforeMonths = 0;
		while (true) {
			boolean yearEqual = beforeCalendar.get(Calendar.YEAR) == afterCalendar
					.get(Calendar.YEAR);
			boolean monthEqual = beforeCalendar.get(Calendar.MONTH) == afterCalendar
					.get(Calendar.MONTH);
			if (yearEqual && monthEqual) {
				break;
			} else {
				if (positive) {
					beforeMonths++;
					beforeCalendar.add(Calendar.MONTH, 1);
				} else {
					beforeMonths--;
					beforeCalendar.add(Calendar.MONTH, -1);
				}
			}
		}
		return beforeMonths;
	}

	/**
	 * 返回给定的beforeDate比afterDate早的天数。如果beforeDate晚于afterDate，则 返回负数。
	 * @param beforeDate 要比较的早的日期
	 * @param afterDate 要比较的晚的日期
	 * @return beforeDate比afterDate早的天数，负数表示晚。
	 */
	@Bizlet("")
	public static int beforeDays(final Date beforeDate, final Date afterDate) {
		Calendar beforeCalendar = Calendar.getInstance();
		beforeCalendar.setTime(beforeDate);
		beforeCalendar.set(Calendar.HOUR, 0);
		beforeCalendar.set(Calendar.SECOND, 0);
		beforeCalendar.set(Calendar.MINUTE, 0);
		Calendar afterCalendar = Calendar.getInstance();
		afterCalendar.setTime(afterDate);
		afterCalendar.set(Calendar.HOUR, 0);
		afterCalendar.set(Calendar.SECOND, 0);
		afterCalendar.set(Calendar.MINUTE, 0);
		boolean positive = true;
		if (beforeDate.after(afterDate)) {
			positive = false;
		}
		int beforeDays = 0;
		while (true) {
			boolean yearEqual = beforeCalendar.get(Calendar.YEAR) == afterCalendar
					.get(Calendar.YEAR);
			boolean monthEqual = beforeCalendar.get(Calendar.MONTH) == afterCalendar
					.get(Calendar.MONTH);
			boolean dayEqual = beforeCalendar.get(Calendar.DATE) == afterCalendar
					.get(Calendar.DATE);
			if (yearEqual && monthEqual && dayEqual) {
				break;
			} else {
				if (positive) {
					beforeDays++;
					beforeCalendar.add(Calendar.DATE, 1);
				} else {
					beforeDays--;
					beforeCalendar.add(Calendar.DATE, -1);
				}
			}
		}
		return beforeDays;
	}

	/**
	 * 获取beforeDate和afterDate之间相差的完整年数，精确到天。负数表示晚。
	 * @param beforeDate 要比较的早的日期
	 * @param afterDate 要比较的晚的日期
	 * @return beforeDate比afterDate早的完整年数，负数表示晚。
	 */
	@Bizlet("")
	public static int beforeRoundYears(final Date beforeDate, final Date afterDate) {
		Date bDate = beforeDate;
		Date aDate = afterDate;
		boolean positive = true;
		if (beforeDate.after(afterDate)) {
			positive = false;
			bDate = afterDate;
			aDate = beforeDate;
		}
		int beforeYears = beforeYears(bDate, aDate);

		int bMonth = getMonth(bDate);
		int aMonth = getMonth(aDate);
		if (aMonth < bMonth) {
			beforeYears--;
		} else if (aMonth == bMonth) {
			int bDay = getDay(bDate);
			int aDay = getDay(aDate);
			if (aDay < bDay) {
				beforeYears--;
			}
		}

		if (positive) {
			return beforeYears;
		} else {
			return new BigDecimal(beforeYears).negate().intValue();
		}
	}

	/**
	 * 获取beforeDate和afterDate之间相差的完整年数，精确到月。负数表示晚。
	 * @param beforeDate 要比较的早的日期
	 * @param afterDate 要比较的晚的日期
	 * @return beforeDate比afterDate早的完整年数，负数表示晚。
	 */
	@Bizlet("")
	public static int beforeRoundAges(final Date beforeDate, final Date afterDate) {
		Date bDate = beforeDate;
		Date aDate = afterDate;
		boolean positive = true;
		if (beforeDate.after(afterDate)) {
			positive = false;
			bDate = afterDate;
			aDate = beforeDate;
		}
		int beforeYears = beforeYears(bDate, aDate);

		int bMonth = getMonth(bDate);
		int aMonth = getMonth(aDate);
		if (aMonth < bMonth) {
			beforeYears--;
		}

		if (positive) {
			return beforeYears;
		} else {
			return new BigDecimal(beforeYears).negate().intValue();
		}
	}

	/**
	 * 获取beforeDate和afterDate之间相差的完整月数，精确到天。负数表示晚。
	 * @param beforeDate 要比较的早的日期
	 * @param afterDate 要比较的晚的日期
	 * @return beforeDate比afterDate早的完整月数，负数表示晚。
	 */
	@Bizlet("")
	public static int beforeRoundMonths(final Date beforeDate, final Date afterDate) {
		Date bDate = beforeDate;
		Date aDate = afterDate;
		boolean positive = true;
		if (beforeDate.after(afterDate)) {
			positive = false;
			bDate = afterDate;
			aDate = beforeDate;
		}
		int beforeMonths = beforeMonths(bDate, aDate);

		int bDay = getDay(bDate);
		int aDay = getDay(aDate);
		if (aDay < bDay) {
			beforeMonths--;
		}

		if (positive) {
			return beforeMonths;
		} else {
			return new BigDecimal(beforeMonths).negate().intValue();
		}
	}

	/**
	 * 根据传入的年、月、日构造日期对象
	 * @param year 年
	 * @param month 月
	 * @param date 日
	 * @return 返回根据传入的年、月、日构造的日期对象
	 */
	@Bizlet("")
	public static Date getDate(final int year, final int month, final int date) {
		Calendar c = Calendar.getInstance();
		c.set(year + 1900, month, date);
		return c.getTime();
	}

	public static Timestamp getDateTime() {
		return new Timestamp(System.currentTimeMillis());
	}

	public static Date getSimpleDate() {
		try {
			return parse(format(getDate()), "yyyy-MM-dd");
		} catch (Exception e) {
			return null;
		}
	}

	public static Timestamp getSimpleDateTime() {
		return new Timestamp(getSimpleDate().getTime());
	}

	public static Date getDate() {
		return new java.util.Date(System.currentTimeMillis());
	}

	public static Date getNow() {
		return new java.util.Date(System.currentTimeMillis());
	}

	/**
	 * 根据传入的日期格式化pattern将传入的日期格式化成字符串。
	 * @param date 要格式化的日期对象
	 * @param pattern 日期格式化pattern
	 * @return 格式化后的日期字符串
	 */
	@Bizlet("")
	public static String format(final Date date, final String pattern) {
		if (date == null) {
			return "";
		}
		DateFormat df = new SimpleDateFormat(pattern);
		return df.format(date);
	}
	
	/**
	 * 根据传染的日期格式化，将传入的字符串格式化成日期
	 * @param date 要格式化的日期对象
	 * @param pattern 日期格式化pattern
	 * @return 格式化后的字符串
	 */
	public static String formatDate(final String date,final String pattern){
		//SimpleDateFormat foramt = new SimpleDateFormat(pattern);
		/*Date dateForamt = null;
		try {
			dateForamt = foramt.parse(date);
			
		} catch (ParseException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}*/
		String dateForamt = date.substring(0,4);
		
		//获取到日期中的月份
		int Monyh = Integer.valueOf(date.substring(5,7));
		if(Monyh <= 9){  //判断月份是否小于等于9，是加上0
			dateForamt = dateForamt + "-0" + Monyh;
		}else{
			dateForamt = dateForamt + "-" + Monyh;
		}
		
		//获取时间中的天
		int day = Integer.valueOf(date.substring(8,10));
		//判断天是否小于等于9，是在天数前加入0，否则不加0
		if(day <= 9){
			dateForamt = dateForamt + "-0" + day;
		}else{
			dateForamt = dateForamt + "-" + day;
		}
		
		return dateForamt;
	}

	/**
	 * 将传入的日期按照默认形势转换成字符串（yyyy-MM-dd）
	 * @param date 要格式化的日期对象
	 * @return 格式化后的日期字符串
	 */
	@Bizlet("")
	public static String format(final Date date) {
		return format(date, YEAR_MONTH_DAY_PATTERN);
	}

	public static String formatNumberDate(final Date anDate) {
		return format(anDate, YMD_NUMBER);
	}

	public static Date parseNumberDate(final String anDate) {
		return parse(anDate, YMD_NUMBER);
	}

	public static String formatDateTime(final Date anDate) {
		return format(anDate, YMDHMS_PATTERN);
	}

	public static String formatDateTime(final Object anDate) {
		try {
			return format((java.util.Date) anDate, YMDHMS_PATTERN);
		} catch (Exception e) {
			return anDate.toString();
		}
	}

	/**
	 * 根据传入的日期格式化patter将传入的字符串转换成日期对象
	 * @param dateStr 要转换的字符串
	 * @param pattern 日期格式化pattern
	 * @return 转换后的日期对象
	 * @throws ParseException 如果传入的字符串格式不合法
	 */
	@Bizlet("")
	public static Date parse(final String dateStr, final String pattern) {
		DateFormat df = new SimpleDateFormat(pattern);
		try {
			return df.parse(dateStr);
		} catch (ParseException e) {
			e.printStackTrace();
			log.equals("解析格式化日期出现异常：");
			return null;
		}
	}

	/**
	 * 将传入的字符串按照默认格式转换为日期对象（yyyy-MM-dd）
	 * @param dateStr 要转换的字符串
	 * @return 转换后的日期对象
	 * @throws ParseException 如果传入的字符串格式不符合默认格式（如果传入的字符串格式不合法）
	 */
	@Bizlet("")
	public static Date parse(final String dateStr) {
		return parse(dateStr, YEAR_MONTH_DAY_PATTERN);
	}

	public static java.sql.Date parseSQLDate(final String anDateStr) {
		return parseSQLDate(anDateStr, YEAR_MONTH_DAY_PATTERN);
	}

	public static java.sql.Date parseSQLDate(final String anDateStr, String anPatent) {
		return toSQLDate(parse(anDateStr, anPatent));
	}

	public static java.sql.Date toSQLDate(Date anDate) {
		if (anDate != null) {
			return new java.sql.Date(anDate.getTime());
		} else {
			return null;
		}
	}

	public static java.sql.Timestamp parseTimestamp(final String anDateStr) {
		return parseTimestamp(anDateStr, YMDHMS_PATTERN);
	}

	public static java.sql.Timestamp parseTimestamp(final String anDateStr, String anPatent) {
		return toSQLDateTime(parse(anDateStr, anPatent));
	}

	public static java.util.Date truncateDate(Date anDate) {
		/*
		 * Calendar cc = Calendar.getInstance(); cc.setTime(anDate);
		 * cc.set(Calendar.HOUR, 0); cc.set(Calendar.MINUTE, 0);
		 * cc.set(Calendar.SECOND, 0); return cc.getTime();
		 */
		try {
			return parse(format(anDate));
		} catch (Exception ex) {
			return anDate;
		}
	}

	public static Timestamp toSQLDateTime(Date anDate) {
		if (anDate != null) {
			return new Timestamp(anDate.getTime());
		} else {
			return null;
		}
	}

	/**
	 * 要进行合法性验证的年月数值
	 * @param yearMonth 验证年月数值
	 * @return 年月是否合法
	 */
	@Bizlet("")
	public static boolean isWeekDay(Date anDate, int anWeek) {
		Calendar cc = Calendar.getInstance();
		cc.setTime(anDate);
		return cc.get(Calendar.DAY_OF_WEEK) == anWeek;
	}

	public static boolean isSunDay(Date anDate) {
		Calendar cc = Calendar.getInstance();
		cc.setTime(anDate);
		return cc.get(Calendar.DAY_OF_WEEK) == Calendar.SUNDAY;
	}

	public static boolean isSaturDay(Date anDate) {
		Calendar cc = Calendar.getInstance();
		cc.setTime(anDate);
		return cc.get(Calendar.DAY_OF_WEEK) == Calendar.SATURDAY;
	}

	public static boolean isRestDay(Date anDate) {
		Calendar cc = Calendar.getInstance();
		cc.setTime(anDate);
		int x = cc.get(Calendar.DAY_OF_WEEK);
		return (x == Calendar.SATURDAY) || (x == Calendar.SUNDAY);
	}

	/**
	 * 要进行合法性验证的年月字符串
	 * @param yearMonthStr 验证年月字符串
	 * @return 年月是否合法
	 */
	@Bizlet("")
	public static boolean isYearMonth(final String yearMonthStr) {
		if (yearMonthStr.length() != 6) {
			return false;
		} else {
			String yearStr = yearMonthStr.substring(0, 4);
			String monthStr = yearMonthStr.substring(4, 6);
			try {
				int year = Integer.parseInt(yearStr);
				int month = Integer.parseInt(monthStr);
				if (year < 1800 || year > 3000) {
					return false;
				}
				if (month < 1 || month > 12) {
					return false;
				}
				return true;
			} catch (Exception e) {
				return false;
			}
		}
	}

	/**
	 * 获取从from到to的年月Integer形式值的列表
	 * @param from 从
	 * @param to 到
	 * @return 年月Integer形式值列表
	 * @throws ParseException
	 */
	@Bizlet("")
	public static List<Integer> getYearMonths(Integer from, Integer to) {
		List<Integer> yearMonths = new ArrayList<Integer>();
		Date fromDate = parseYearMonth(from);
		Date toDate = parseYearMonth(to);
		if (fromDate.after(toDate)) {
			throw new IllegalArgumentException("'from' date should before 'to' date!");
		}
		Date tempDate = fromDate;
		while (tempDate.before(toDate)) {
			yearMonths.add(getYearMonth(tempDate));
			tempDate = addMonth(tempDate, 1);
		}
		if (!from.equals(to)) {
			yearMonths.add(to);
		}
		return yearMonths;
	}

	public static boolean isBirthDay(java.util.Date anDate, java.util.Date anOtherDate) {
		if ((anDate != null) && (anOtherDate != null)) {
			return (getMonth(anDate) == getMonth(anOtherDate))
					&& (getDay(anDate) == getDay(anOtherDate));
		}
		return false;
	}

	public static int weekOfYear(java.util.Date anDate) {
		Calendar cc = Calendar.getInstance();
		cc.setTime(anDate);
		return cc.get(Calendar.WEEK_OF_YEAR);
	}

	public static java.util.Date findMaxDayOfMonth(java.util.Date anDate) {
		Calendar cc = Calendar.getInstance();
		cc.setTime(anDate);
		cc.add(Calendar.MONTH, 1);
		int kk = cc.get(Calendar.DAY_OF_MONTH);
		cc.add(Calendar.DAY_OF_MONTH, -kk);
		return cc.getTime();
	}

	public static java.util.Date findMinDayOfMonth(java.util.Date anDate) {
		Calendar cc = Calendar.getInstance();
		cc.setTime(anDate);
		int kk = cc.get(Calendar.DAY_OF_MONTH);
		cc.add(Calendar.DAY_OF_MONTH, -kk + 1);
		return cc.getTime();
	}

	public static String toDayYearMonth() {
		java.util.Date dd = new java.util.Date(System.currentTimeMillis());
		return format(dd, "yyyyMM");
	}

	public static java.util.Date findMonthMaxDay(java.util.Date anDate) {
		Calendar cc = Calendar.getInstance();
		cc.setTime(anDate);
		cc.set(Calendar.DAY_OF_MONTH, cc.getActualMaximum(Calendar.DAY_OF_MONTH));
		return cc.getTime();
	}

	public static java.util.Date findPreMonthMaxDay(java.util.Date anDate) {
		Calendar cc = Calendar.getInstance();
		cc.setTime(anDate);
		cc.set(Calendar.DAY_OF_MONTH, cc.getActualMinimum(Calendar.DAY_OF_MONTH));
		cc.add(Calendar.DAY_OF_MONTH, -1);
		return cc.getTime();
	}

	/**
	 * 计算两个时间之间的间隔
	 * @param beginTime
	 * @param endTime
	 * @return
	 */
	@Bizlet("")
	public static String getIntervalTimeStr(long beginTime, long endTime) {
		String str = "";
		long interval = endTime - beginTime;
		long day = interval / (1000 * 60 * 60 * 24);
		long hour = (interval - day * (1000 * 60 * 60 * 24)) / (1000 * 60 * 60);
		long min = (interval - day * (1000 * 60 * 60 * 24) - hour * (1000 * 60 * 60)) / (1000 * 60);
		long sec = (interval - day * (1000 * 60 * 60 * 24) - hour * (1000 * 60 * 60) - min * (1000 * 60)) / 1000;
		if (day > 0) {
			str = day + "天" + hour + "小时" + min + "分" + sec + "秒";
		} else if (hour > 0) {
			str = hour + "小时" + min + "分" + sec + "秒";
		} else if (min > 0) {
			str = min + "分" + sec + "秒";
		} else if (sec > 0) {
			str = sec + "秒";
		} else {
			str = interval + "毫秒";
		}
		return str;
	}

	/**
	 * 判断输入日期是否为工作日
	 * @param inputDay 输入日期
	 * @return 工作日时返回true,否则返回false
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static boolean isWorkDay(String inputDay) {
		boolean isWorkDay = false;
		try {
			Object[] objs = LogicComponentFactory.create("com.phfund.commonUtil.DjWorkDay").invoke("isWorkDay", new Object[] { inputDay });
			if (null != objs && objs.length > 0) {
				String result = (String) objs[0];
				// 1-是，0-否
				if ("1".equals(result)) {
					isWorkDay = true;
				}
			}
		} catch (Throwable e) {
			LogUtil.logError("DateUtil.isWorkDay fail: ", e, new Object[] { "" });
		}
		return isWorkDay;
	}

	/**
	 * 获取下一个工作日
	 * @param inputDay 输入日期
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String getNextWorkDay(String inputDay) {
		String nextWorkDay = null;
		try {
			Object[] objs = LogicComponentFactory.create("com.phfund.commonUtil.DjWorkDay").invoke("getNextWorkDay", new Object[] { inputDay });
			if (null != objs && objs.length > 0) {
				nextWorkDay = (String) objs[0];
			}
		} catch (Throwable e) {
			LogUtil.logError("DateUtil.getNextWorkDay fail: ", e, new Object[] { "" });
		}
		return nextWorkDay;
	}

	/**
	 * 获取上一个工作日
	 * @param inputDay 输入日期
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String getPreWorkDay(String inputDay) {
		String preWorkDay = null;
		try {
			Object[] objs = LogicComponentFactory.create("com.phfund.commonUtil.DjWorkDay").invoke("getPreWorkDay", new Object[] { inputDay });
			if (null != objs && objs.length > 0) {
				preWorkDay = (String) objs[0];
			}
		} catch (Throwable e) {
			LogUtil.logError("DateUtil.getPreWorkDay fail: ", e, new Object[] { "" });
		}
		return preWorkDay;
	}

	/**
	 * 根据输入日期获取该日期的上一个月（年月:yyyyMM）
	 * @param inputDay 输入日期
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String getLastMonth(String inputDay) {
		if (StringUtils.isBlank(inputDay) || inputDay.length() < 8) {
			return "";
		}
		inputDay = inputDay.replaceAll("-", "").trim();
		int year = Integer.valueOf(inputDay.substring(0, 4));
		String month = inputDay.substring(4, 6);
		String yyyy = String.valueOf(year);// 年
		String MM = "";// 月
		if ("01".equals(month)) {
			yyyy = String.valueOf(year - 1);
			MM = "12";
		} else if ("02".equals(month)) {
			MM = "01";
		} else if ("03".equals(month)) {
			MM = "02";
		} else if ("04".equals(month)) {
			MM = "03";
		} else if ("05".equals(month)) {
			MM = "04";
		} else if ("06".equals(month)) {
			MM = "05";
		} else if ("07".equals(month)) {
			MM = "06";
		} else if ("08".equals(month)) {
			MM = "07";
		} else if ("09".equals(month)) {
			MM = "08";
		} else if ("10".equals(month)) {
			MM = "09";
		} else if ("11".equals(month)) {
			MM = "10";
		} else if ("12".equals(month)) {
			MM = "11";
		}
		return yyyy + MM;
	}

	/**
	 * 根据输入日期获取该日期的下一个月（年月:yyyyMM）
	 * @param inputDay 输入日期
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String getNextMonth(String inputDay) {
		if (StringUtils.isBlank(inputDay) || inputDay.length() < 8) {
			return "";
		}
		inputDay = inputDay.replaceAll("-", "").trim();
		int year = Integer.valueOf(inputDay.substring(0, 4));
		String month = inputDay.substring(4, 6);
		String yyyy = String.valueOf(year);// 年
		String MM = "";// 月
		if ("01".equals(month)) {
			MM = "02";
		} else if ("02".equals(month)) {
			MM = "03";
		} else if ("03".equals(month)) {
			MM = "04";
		} else if ("04".equals(month)) {
			MM = "05";
		} else if ("05".equals(month)) {
			MM = "06";
		} else if ("06".equals(month)) {
			MM = "07";
		} else if ("07".equals(month)) {
			MM = "08";
		} else if ("08".equals(month)) {
			MM = "09";
		} else if ("09".equals(month)) {
			MM = "10";
		} else if ("10".equals(month)) {
			MM = "11";
		} else if ("11".equals(month)) {
			MM = "12";
		} else if ("12".equals(month)) {
			MM = "01";
			yyyy = String.valueOf(year + 1);
		}
		return yyyy + MM;
	}

	/**
	 * 根据输入日期获取该日期的上一个月的最后一天的日期（yyyyMMdd）
	 * @param inputDay 输入日期
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String getLastMonthLastDay(String inputDay) {
		String lastMonth = getLastMonth(inputDay);
		Date date = DateUtil.parse(lastMonth + "01", DateUtil.YMD_NUMBER);
		int lastDay = getDay(findMaxDayOfMonth(date));
		return lastMonth + String.valueOf(lastDay);
	}
	
	/**
	 * 从O32系统交易日历中取差量交易日期
	 * @param conn 数据库连接，若不传，则新建连接待本方法用完后关闭
	 * @param calcDate 计算参考日期，格式：yyyyMMdd
	 * @param dateType 交易日类型：00-沪深交易日；
	 * @param num 计算交易日差量，负数时往前计算
	 * @return 计算后的交易日期，格式：yyyyMMdd
	 */
	@Bizlet("从O32系统交易日历中取差量交易日期")
	public static String getCalculateTradeDay(Connection conn, String calcDate, String dateType, Integer num){
		StringBuffer sb = new StringBuffer();
		String result = "";
		boolean isCloseConn = false;
		try{
			if(StringUtils.isBlank(calcDate) || num==null){
				return result;
			}
			if(conn==null || conn.isClosed()){
				//获取O32系统数据库连接
				conn = JDBCUtil.getConnByDataSourceId(CacheUtil.getO32CacheDataSourceName());
				isCloseConn = true;
			}
			
			calcDate = calcDate.replaceAll("-", "");
			//交易日类型为空时取“00-沪深交易日”
			if(StringUtils.isBlank(dateType)){
				dateType = "00";
			}
			sb.append("with calendarCalculate as ")
			  .append(" (select a.*, rank() over(partition by vc_tradeday_type order by l_date) rn ")
			  .append("    from trade.tmarkettradeday a where a.vc_tradeday_type = '"+dateType+"' and a.c_trade_flag = '1') ")
			  .append("select l_date from calendarCalculate b ")
			  .append(" where b.rn = nvl((select c.rn + ("+num+") from calendarCalculate c where c.l_date = "+calcDate+"), ")
			  .append("                  (select min(c.rn + ("+num+")) from calendarCalculate c where c.l_date > "+calcDate+")) ");
			
			result = JDBCUtil.getValueBySql(conn, sb.toString());
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sb.setLength(0);
			sb = null;
			if(isCloseConn){
				JDBCUtil.releaseResource(conn, null, null);
			}
		}
		return result;
	}
	
	/**
	 * 判断输入日期是否为交易日
	 * @param conn 数据库连接
	 * @param inputDate 输入日期，格式：yyyyMMdd
	 * @param dateType 交易日类型：00-沪深交易日；
	 * @return
	 */
	@Bizlet("判断输入日期是否为交易日")
	public static boolean isTradeDay(Connection conn, String inputDate, String dateType){
		boolean flag = false;
		if(conn==null || StringUtils.isBlank(inputDate)){
			return flag;
		}
		inputDate = inputDate.replaceAll("-", "");
		//交易日类型为空时取“00-沪深交易日”
		if(StringUtils.isBlank(dateType)){
			dateType = "00";
		}
		StringBuffer sb = new StringBuffer();
		sb.append("select 1 from trade.tmarkettradeday t where t.vc_tradeday_type='"+dateType+"' and t.c_trade_flag='1' and t.l_date="+inputDate);
		String result = JDBCUtil.getValueBySql(conn, sb.toString());
		if(StringUtils.isNotEmpty(result)){
			flag = true;
		}
		return flag;
	}

	public static void main(String[] args) throws Exception {
		// Date date = DateUtil.parseTimestamp(args[0]);
		// System.out.println(DateUtil.formatDateTime(date));
		// System.out
		// .println(DateUtil.formatDateTime(DateUtil.truncateDate(date)));
		// long xx = System.nanoTime();
		// DateUtil.truncateDate(date);
		// log.info(System.nanoTime() - xx);
		System.out.println("LastMonth= " + getLastMonth("20150228"));
		System.out.println("NextMonth= " + getNextMonth("20150228"));
		System.out.println("getLastMonthLastDay= " + getLastMonthLastDay("20150403"));
		Date date = new Date();

		System.out.println("weekOfYear=" + weekOfYear(date));
		System.out.println("getDay=" + getDay(date));
		System.out.println("findMinDayOfMonth=" + findMinDayOfMonth(date));
		System.out.println("findMaxDayOfMonth=" + getDay(findMaxDayOfMonth(date)));
	}

}
