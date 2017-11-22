package com.lizhifeng.hive;

import org.apache.hadoop.hive.ql.exec.UDF;

public class AddRepayNum extends UDF {

	public static String evaluate(String repay_plan) {

		if (repay_plan == null) {
			return null;
		}

		String[] plans = repay_plan.split("interest");
		if (plans.length == 1) {
			return repay_plan;
		}
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < plans.length - 1; i++) {
			sb.append(plans[i]);
			sb.append("repay_num\":\"").append(i + 1).append("\",\"interest");
		}
		sb.append(plans[plans.length - 1]);
		return sb.toString();
	}
}
