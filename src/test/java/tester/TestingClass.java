/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package tester;

/**
 *
 * @author rcosco
 */
public class TestingClass {
    public static void main(String[] args) {
        
////        
////        String safe = ESAPI.encoder().encodeForHTML( "dsaddsada" );
////        
////        System.out.println("tester.TestingClass.main() "+safe);
        
//        System.out.println("tester.TestingClass.main() "+formatDoubleforMysql("5.001.000,00"));
        
//        DecimalFormat formatter = (DecimalFormat) NumberFormat.getCurrencyInstance(Locale.ITALY);
//            DecimalFormatSymbols symbols = formatter.getDecimalFormatSymbols();
//            System.out.println("tester.TestingClass.main() "+symbols.getCurrencySymbol());
    }
//    public static void main(String[] args) {
//        System.out.println("rc.so.util.Utility.main() " + getValueDiff("1006.40", "1006.45", "-0.05", "1.00000000", true));
//        System.out.println("rc.so.util.Utility.main() " + formatDoubleforMysql(getValueDiff("1006.40", "1006.45", "-0.05", "1.00000000", true)));
//        System.out.println("rc.so.util.Utility.main() " + parseDoubleR(getValueDiff("1006.40", "1006.45", "-0.05", "1.00000000", true)));
//    }

//    public static void main(String[] args) {
////        out.println(login_TA("forexchange_test", "040"));
//
//////////
////////////        try {
////////////            byte[] base = Base64.decodeBase64(Engine.getConf("path.rep1cdc"));
////////////
//////////////            Engine.updateConf("path.rep1_2021", Base64.encodeBase64String(FileUtils.readFileToByteArray(new File("C:\\TEMP\\rep1.xlsx"))));
////////////
////////////            FileUtils.writeByteArrayToFile(new File("C:\\Maccorp\\modificareport2022.xlsx"), base);
////////////        } catch (IOException ex) {
////////////            ex.printStackTrace();
////////////        }
//////////        String ps = "com.mysql.cj.jdbc.ClientPreparedStatement: INSERT INTO anagrafica_client VALUES ('220807085731040wE6xhLo103','MELENDEZ','VICTOR MANUEL','M','---','069','PHOENIX','1022 KELLY HALE DR','\\','-','USA','---','069','04/06/1957','PS','A01969053','08/12/2021','07/12/2031','STATI UNITI D' AMERICA','STATI UNITI D' AMERICA','','','19.90','-','2022-08-07 08:57:31','NO')";
//////////
//////////        StringBuilder ps_final = new StringBuilder();
//////////
//////////        if (ps.contains("UPDATE") && ps.contains("', ") && !ps.contains("ch_transaction_doc")) {
//////////            Splitter.on(" = ").splitToList(ps).forEach(s1 -> {
//////////
//////////                if (!s1.contains("WHERE") && !s1.contains("AND ") && !s1.startsWith("''")) {
//////////                    Splitter.on("', ").splitToList(s1).forEach(s2 -> {
//////////                        String content = s2.startsWith("'") && !s2.endsWith(")") && !s2.endsWith("'") && !s2.contains("UPDATE")
//////////                                && !s2.contains("SELECT") && !s2.contains("FROM") && !s2.contains("WHERE") ? StringUtils.substring(s2, 1) : s2;
////////////                        System.out.println(content);
//////////                        if (!content.equals(s2)) {
//////////                            System.out.println(s2);
//////////                            String dest = StringUtils.replace(content, "'", "\\'");
//////////                            System.out.println(content);
//////////                            System.out.println(dest);
//////////                            ps_final.append("'").append(dest);
//////////                            ps_final.append("',");
//////////                        } else {
//////////                            ps_final.append(content);
//////////                            ps_final.append(" = ");
//////////                        }
//////////
////////////                    System.out.println(s2);
//////////                    });
//////////                } else {
//////////                    ps_final.append(s1).append(" = ");
//////////                }
////////////                if (!content.equals(s1)) {
////////////                    System.out.println(s1);
////////////                    String dest = StringUtils.replace(content, "'", "\\'");
////////////                    System.out.println(content);
////////////                    System.out.println(dest);
////////////                    ps_final.append("'").append(dest);
////////////                } else {
////////////                    ps_final.append(content);
////////////                }
////////////                ps_final.append("',");
//////////            });
//////////        } else if (ps.contains("',")) {
////////////            System.out.println("tester.TestingClass.main(2)");
//////////            Splitter.on("',").splitToList(ps).forEach(s1 -> {
//////////                String content = s1.startsWith("'") && !s1.endsWith(")") && !s1.contains("UPDATE") && !s1.equals("'\\'")
//////////                        && !s1.contains("SELECT") && !s1.contains("FROM") && !s1.contains("WHERE") 
//////////                        ? StringUtils.substring(s1, 1) : s1;
//////////                if (!content.equals(s1)) {
//////////                    System.out.println(s1);
//////////                    String dest = StringUtils.replace(content, "'", "\\'");
//////////                    dest = StringUtils.replace(dest, "\\", "-");
////////////                    System.out.println(content);
////////////                    System.out.println(dest);
//////////                    ps_final.append("'").append(dest);
//////////                } else {
//////////                    ps_final.append(content);
//////////                }
//////////                ps_final.append("',");
//////////            });
//////////        }
//////////
//////////        System.out.println(StringUtils.substring(ps_final.toString(), 0, ps_final.toString().length() - 2).trim());
//    }
}
