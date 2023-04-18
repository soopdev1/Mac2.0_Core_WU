/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rc.so.report;

import com.itextpdf.text.BaseColor;
import static com.itextpdf.text.BaseColor.LIGHT_GRAY;
import com.itextpdf.text.Chunk;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import static com.itextpdf.text.Element.ALIGN_LEFT;
import static com.itextpdf.text.Element.ALIGN_RIGHT;
import com.itextpdf.text.Font;
import static com.itextpdf.text.Font.BOLD;
import static com.itextpdf.text.Font.BOLDITALIC;
import static com.itextpdf.text.Font.NORMAL;
import com.itextpdf.text.FontFactory;
import static com.itextpdf.text.FontFactory.getFont;
import static com.itextpdf.text.FontFactory.getFont;
import static com.itextpdf.text.FontFactory.getFont;
import static com.itextpdf.text.FontFactory.getFont;
import static com.itextpdf.text.FontFactory.getFont;
import static com.itextpdf.text.FontFactory.getFont;
import static com.itextpdf.text.FontFactory.getFont;
import static com.itextpdf.text.FontFactory.getFont;
import com.itextpdf.text.PageSize;
import static com.itextpdf.text.PageSize.A4;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.Rectangle;
import static com.itextpdf.text.Rectangle.BOTTOM;
import static com.itextpdf.text.Rectangle.NO_BORDER;
import static com.itextpdf.text.Rectangle.TOP;
import com.itextpdf.text.pdf.BaseFont;
import static com.itextpdf.text.pdf.BaseFont.HELVETICA;
import static com.itextpdf.text.pdf.BaseFont.WINANSI;
import com.itextpdf.text.pdf.ColumnText;
import static com.itextpdf.text.pdf.ColumnText.showTextAligned;
import static com.itextpdf.text.pdf.ColumnText.showTextAligned;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import static com.itextpdf.text.pdf.PdfWriter.getInstance;
import com.itextpdf.text.pdf.draw.LineSeparator;
import rc.so.entity.Users;
import rc.so.util.Engine;
import static rc.so.util.Engine.get_user;
import static rc.so.util.Engine.insertTR;
import rc.so.util.Utility;
import static rc.so.util.Utility.fd;
import static rc.so.util.Utility.formatDoubleforMysql;
import static rc.so.util.Utility.formatMysqltoDisplay;
import static rc.so.util.Utility.generaId;
import static rc.so.util.Utility.generaId;
import static rc.so.util.Utility.roundDoubleandFormat;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import static java.lang.String.valueOf;
import static java.lang.String.valueOf;
import static java.lang.String.valueOf;
import static java.lang.String.valueOf;
import static java.lang.String.valueOf;
import static java.lang.String.valueOf;
import static java.lang.String.valueOf;
import static java.lang.String.valueOf;
import static java.lang.Thread.currentThread;
import java.util.ArrayList;
import org.apache.commons.codec.binary.Base64;
import static org.apache.commons.codec.binary.Base64.encodeBase64;
import org.apache.commons.io.FileUtils;
import static org.apache.commons.io.FileUtils.readFileToByteArray;
import static org.apache.commons.io.FilenameUtils.normalize;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import static org.apache.poi.hssf.usermodel.HSSFFont.FONT_ARIAL;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.BorderStyle;
import static org.apache.poi.ss.usermodel.BorderStyle.THIN;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import static org.apache.poi.ss.usermodel.HorizontalAlignment.LEFT;
import static org.apache.poi.ss.usermodel.HorizontalAlignment.RIGHT;
/**
 *
 * @author fplacanica
 */
public class NoChangeTransactionListForUser {

    //column

    /**
     *
     */
    public static final float[] columnWidths0 = new float[]{70f, 30f};

    /**
     *
     */
    public static final float[] columnWidths1 = new float[]{60f, 30f};

    /**
     *
     */
    public static float[] columnWidths2 = new float[]{3f, 7f, 25f, 7f, 20f, 50f, 25f, 10f, 15f};

    /**
     *
     */
    public static float[] columnWidths3 = new float[]{7f, 25f, 7f, 20f, 50f, 25f, 10f, 15f};

    /**
     *
     */
    public static float[] columnWidths4 = new float[]{30f, 20f, 15f, 15f, 10f, 15f};

    /**
     *
     */
    public static float[] columnWidths5 = new float[]{30f, 20f, 15f, 15f, 10f, 15f};

    /**
     *
     */
    public static float[] columnWidths6 = new float[]{30f, 20f, 15f, 15f, 10f, 15f};
    final String intestazionePdf = "No Change category transaction list for User";
    Phrase vuoto = new Phrase("\n");

    //resource
//    public static final String logo = "web/resource/logocl.png";
    //other

    /**
     *
     */
    public static final String br = "\n";

    /**
     *
     */
    public static final String blank = " ";

    Font f0_bold, f1_bold, f2_bold, f1_normal, f2_normal, f3_normal, f3_bold, f4_bold;

    /**
     * Costructor
     */
    public NoChangeTransactionListForUser() {

        this.f0_bold = getFont(HELVETICA, WINANSI, 14.04f, BOLD);
        this.f1_bold = getFont(HELVETICA, WINANSI, 9.96f, BOLD);
        this.f2_bold = getFont(HELVETICA, WINANSI, 8f, BOLD);
        this.f3_bold = getFont(HELVETICA, WINANSI, 8f, BOLDITALIC);
        this.f4_bold = getFont(HELVETICA, WINANSI, 6.96f, BOLD);
        this.f1_normal = getFont(HELVETICA, WINANSI, 9.96f, NORMAL);
        this.f2_normal = getFont(HELVETICA, WINANSI, 8f, NORMAL);
        this.f3_normal = getFont(HELVETICA, WINANSI, 6.96f, NORMAL);

    }

    /**
     *
     * @param path
     * @param nctllist
     * @param colonne
     * @param datereport1
     * @param datereport2
     * @return
     */
    public String receipt(String path, ArrayList<NoChangeTransactionListForUser_value> nctllist, ArrayList<String> colonne, String datereport1, String datereport2) {

//        String outputfile = "NoChangeTransactionListForUser.pdf";
        try {
            File pdf = new File(normalize(path + generaId(50) + "NoChangeTransactionListForUser.pdf"));
            Document document = new Document(A4.rotate(), 20, 20, 20, 20);
            OutputStream ou = new FileOutputStream(pdf);
            PdfWriter wr = getInstance(document, ou);
            document.open();

            for (int w = 0; w < nctllist.size(); w++) {

                NoChangeTransactionListForUser_value nctl = nctllist.get(w);

                PdfPTable table = new PdfPTable(2);
                table.setWidths(columnWidths0);
                table.setWidthPercentage(100);

                Phrase phrase1 = new Phrase();
                phrase1.add(new Chunk(intestazionePdf + " From " + datereport1 + " To " + datereport2, f3_bold));
                PdfPCell cell1 = new PdfPCell(phrase1);
                cell1.setBorder(NO_BORDER);

                //Paragraph pa1 = new Paragraph(new Phrase("From " + datereport1 + " To" + datereport2, f2_normal));
                Paragraph pa1 = new Paragraph(new Phrase("", f2_normal));
                pa1.setAlignment(ALIGN_RIGHT);
                PdfPCell cell2 = new PdfPCell(pa1);
                cell2.setBorder(NO_BORDER);
                cell2.setHorizontalAlignment(ALIGN_RIGHT);

                Phrase phrase3 = new Phrase();
                phrase3.add(new Chunk("\n " + nctl.getId_filiale() + " " + nctl.getDe_filiale(), f3_normal));
                PdfPCell cell3 = new PdfPCell(phrase3);
                cell3.setBorder(NO_BORDER);

                Phrase phrase4 = new Phrase();
                phrase4.add(new Chunk("", f3_normal));
                PdfPCell cell4 = new PdfPCell(phrase4);
                cell4.setBorder(NO_BORDER);

                table.addCell(cell1);
                table.addCell(cell2);
                table.addCell(cell3);
                table.addCell(cell4);
                document.add(table);

                vuoto.setFont(f3_normal);
                document.add(vuoto);

                PdfPTable table2 = new PdfPTable(colonne.size());
                table2.setWidths(columnWidths2);
                table2.setWidthPercentage(100);

                PdfPCell[] list = new PdfPCell[colonne.size()];
                //mi scandisco le colonne
                for (int j = 0; j < colonne.size(); j++) {
                    Phrase phraset1 = new Phrase();
                    phraset1.add(new Chunk(colonne.get(j), f4_bold));
                    PdfPCell cellt1 = new PdfPCell(phraset1);
                    cellt1.setHorizontalAlignment(ALIGN_RIGHT);
                    cellt1.setBorder(BOTTOM | TOP);
                    cellt1.setFixedHeight(20f);
                    cellt1.setBackgroundColor(LIGHT_GRAY);
                    //cellt1.setBorder(Rectangle.BOTTOM);
                    cellt1.setBorderWidth(0.7f);
                    if (j == 2 || j == 4 || j == 5 || j == 6) {
                        cellt1.setHorizontalAlignment(ALIGN_LEFT);
                    }
                    list[j] = cellt1;

                }

                PdfPTable table3 = new PdfPTable(colonne.size());
                table3.setWidths(columnWidths2);
                table3.setWidthPercentage(100);

                for (PdfPCell list1 : list) {
                    PdfPCell temp = (PdfPCell) (list1);
                    table3.addCell(temp);
                }

                document.add(table3);

                LineSeparator sep = new LineSeparator();
                sep.setOffset(-2);
                sep.setLineWidth((float) 0.5);

                //  document.add(table2);
                // document.add(sep);
                ArrayList<NoChangeTransactionListForUser_value> dati = nctl.getDati();
                PdfPCell cell;
                Phrase phraset;
                PdfPCell cellt;

                ArrayList<String> user = new ArrayList<>();
                for (int x = 0; x < dati.size(); x++) {
                    NoChangeTransactionListForUser_value temp = dati.get(x);
                    if (!user.contains(temp.getUser())) {
                        user.add(temp.getUser());
                    }
                }

                double tot = 0;
                double totQuantity = 0;
                double totParz;
                double totParzQuantity;

                int numtranin = 0, numdeletran = 0, numtranout = 0, numtotaltran = 0;
                float availableSpace;
                boolean write = false;
                // scorro per utenti
                for (int n = 0; n < user.size(); n++) {

                    PdfPTable table4 = new PdfPTable(2);
                    table4.setWidths(columnWidths0);
                    table4.setWidthPercentage(100);

                    Users us = get_user(user.get(n));

                    phraset = new Phrase();
                    phraset.add(new Chunk(us.getCod() + " " + us.getDe_cognome() + " " + us.getDe_nome(), f4_bold));
                    cellt = new PdfPCell(phraset);
                    cellt.setHorizontalAlignment(ALIGN_LEFT);
                    cellt.setBorder(BOTTOM);
                    table4.addCell(cellt);

                    phraset = new Phrase();
                    phraset.add(new Chunk("", f4_bold));
                    cellt = new PdfPCell(phraset);
                    cellt.setHorizontalAlignment(ALIGN_LEFT);
                    cellt.setBorder(BOTTOM);
                    table4.addCell(cellt);

                    document.add(table4);

                    ArrayList<String> category = new ArrayList<>();
                    for (int x = 0; x < dati.size(); x++) {
                        NoChangeTransactionListForUser_value temp = (NoChangeTransactionListForUser_value) dati.get(x);
                        if (temp.getUser().equals(user.get(n))) {

                            if (!category.contains(temp.getCategoryTrans())) {
                                category.add(temp.getCategoryTrans());

                            }
                        }
                    }

                    for (int j = 0; j < category.size(); j++) {

                        totParz = 0;
                        totParzQuantity = 0;

                        for (int i = 0; i < dati.size(); i++) {

                            NoChangeTransactionListForUser_value temp = (NoChangeTransactionListForUser_value) dati.get(i);

                            availableSpace = wr.getVerticalPosition(true) - document.bottomMargin();

                            if (temp.getUser().equals(user.get(n))) {

                                if (temp.getCategoryTrans().equals(category.get(j))) {

                                    if (temp.getInout().equals("1") || temp.getInout().equals("3")) {
                                        numtranin++;
                                    } else if (temp.getInout().equals("2") || temp.getInout().equals("4")) {
                                        numtranout++;
                                    }

                                    if (temp.getAnnullato().equals("1")) {
                                        numdeletran++;
                                    } else {
                                        if(!temp.getKindTrans().toLowerCase().contains("acquisto") && !temp.getKindTrans().toLowerCase().contains("buy")){
                                        totParz += fd(formatDoubleforMysql(temp.getTotal()));
                                        }
                                        totParzQuantity += fd(formatDoubleforMysql(temp.getQuantity()));
                                    }

                                    table3 = new PdfPTable(colonne.size());
                                    table3.setWidths(columnWidths2);
                                    table3.setWidthPercentage(100);

                                    if (temp.getAnnullato().equals("1")) {
                                        phraset = new Phrase();
                                        phraset.add(new Chunk("D", f3_bold));
                                        cellt = new PdfPCell(phraset);
                                        cellt.setHorizontalAlignment(ALIGN_RIGHT);
                                        cellt.setBorder(BOTTOM);
                                        table3.addCell(cellt);
                                    } else {
                                        phraset = new Phrase();
                                        phraset.add(new Chunk("", f3_normal));
                                        cellt = new PdfPCell(phraset);
                                        cellt.setHorizontalAlignment(ALIGN_RIGHT);
                                        cellt.setBorder(BOTTOM);
                                        table3.addCell(cellt);
                                    }

                                    phraset = new Phrase();
                                    phraset.add(new Chunk(temp.getUser(), f3_normal));
                                    cellt = new PdfPCell(phraset);
                                    cellt.setHorizontalAlignment(ALIGN_RIGHT);
                                    cellt.setBorder(BOTTOM);
                                    table3.addCell(cellt);

                                    phraset = new Phrase();
                                    phraset.add(new Chunk(temp.getCategoryTrans(), f3_normal));
                                    cellt = new PdfPCell(phraset);
                                    cellt.setHorizontalAlignment(ALIGN_LEFT);
                                    cellt.setBorder(BOTTOM);
                                    table3.addCell(cellt);

                                    phraset = new Phrase();
                                    phraset.add(new Chunk(temp.getTill(), f3_normal));
                                    cellt = new PdfPCell(phraset);
                                    cellt.setHorizontalAlignment(ALIGN_RIGHT);
                                    cellt.setBorder(BOTTOM);
                                    table3.addCell(cellt);

                                    phraset = new Phrase();
                                    phraset.add(new Chunk(temp.getDateTime(), f3_normal));
                                    cellt = new PdfPCell(phraset);
                                    cellt.setHorizontalAlignment(ALIGN_LEFT);
                                    cellt.setBorder(BOTTOM);
                                    table3.addCell(cellt);

                                    phraset = new Phrase();
                                    phraset.add(new Chunk(temp.getKindTrans(), f3_normal));
                                    cellt = new PdfPCell(phraset);
                                    cellt.setHorizontalAlignment(ALIGN_LEFT);
                                    cellt.setBorder(BOTTOM);
                                    table3.addCell(cellt);

                                    phraset = new Phrase();
                                    phraset.add(new Chunk(temp.getNote(), f3_normal));
                                    cellt = new PdfPCell(phraset);
                                    cellt.setHorizontalAlignment(ALIGN_LEFT);
                                    cellt.setBorder(BOTTOM);
                                    table3.addCell(cellt);

                                    phraset = new Phrase();
                                    phraset.add(new Chunk(temp.getQuantity(), f3_normal));
                                    cellt = new PdfPCell(phraset);
                                    cellt.setHorizontalAlignment(ALIGN_RIGHT);
                                    cellt.setBorder(BOTTOM);
                                    table3.addCell(cellt);

                                    phraset = new Phrase();
                                    phraset.add(new Chunk(temp.getTotal(), f3_normal));
                                    cellt = new PdfPCell(phraset);
                                    cellt.setHorizontalAlignment(ALIGN_RIGHT);
                                    cellt.setBorder(BOTTOM);
                                    table3.addCell(cellt);

                                    document.add(table3);

                                    //
                                }

                                availableSpace = wr.getVerticalPosition(true) - document.bottomMargin();

                            }

                            if ((availableSpace < 80) || ((n == (user.size() - 1)) && (i == (dati.size() - 1)) && (j == (category.size() - 1)))) {

                                write = true;
                                //footer
                                PdfContentByte cb = wr.getDirectContent();
                                showTextAligned(cb, ALIGN_RIGHT, footer(valueOf(numtranin), valueOf(numdeletran)),
                                        (document.right() - document.left()) / 2 + document.leftMargin(),
                                        document.bottom() + 10, 0);

                                showTextAligned(cb, ALIGN_RIGHT, footer2(valueOf(numtranout), valueOf(numtranin + numtranout - numdeletran)),
                                        (document.right() - document.left()) / 2 + document.leftMargin(),
                                        document.bottom(), 0);

                                //
                                numtranin = 0;
                                numdeletran = 0;
                                numtranout = 0;
                                numtotaltran = 0;

                                if (availableSpace < 185) {
                                    document.newPage();
                                    write = false;
                                }

                            }

                        }
                        //linea  parziali
                        PdfPTable table5 = new PdfPTable(colonne.size());
                        table5.setWidths(columnWidths2);
                        table5.setWidthPercentage(100);

                        phraset = new Phrase();
                        phraset.add(new Chunk("", f3_normal));
                        cellt = new PdfPCell(phraset);
                        cellt.setHorizontalAlignment(ALIGN_RIGHT);
                        cellt.setBorder(BOTTOM);
                        table5.addCell(cellt);

                        phraset = new Phrase();
                        phraset.add(new Chunk("", f3_normal));
                        cellt = new PdfPCell(phraset);
                        cellt.setHorizontalAlignment(ALIGN_RIGHT);
                        cellt.setBorder(BOTTOM);
                        table5.addCell(cellt);

                        phraset = new Phrase();
                        phraset.add(new Chunk("", f3_normal));
                        cellt = new PdfPCell(phraset);
                        cellt.setHorizontalAlignment(ALIGN_RIGHT);
                        cellt.setBorder(BOTTOM);
                        table5.addCell(cellt);

                        phraset = new Phrase();
                        phraset.add(new Chunk("", f3_normal));
                        cellt = new PdfPCell(phraset);
                        cellt.setHorizontalAlignment(ALIGN_RIGHT);
                        cellt.setBorder(BOTTOM);
                        table5.addCell(cellt);

                        phraset = new Phrase();
                        phraset.add(new Chunk("", f4_bold));
                        cellt = new PdfPCell(phraset);
                        cellt.setHorizontalAlignment(ALIGN_RIGHT);
                        cellt.setBorder(BOTTOM);
                        table5.addCell(cellt);

                        phraset = new Phrase();
                        phraset.add(new Chunk("Total from transaction listed for category", f4_bold));
                        cellt = new PdfPCell(phraset);
                        cellt.setHorizontalAlignment(ALIGN_LEFT);
                        cellt.setBorder(BOTTOM);
                        table5.addCell(cellt);

                        phraset = new Phrase();
                        phraset.add(new Chunk("", f4_bold));
                        cellt = new PdfPCell(phraset);
                        cellt.setHorizontalAlignment(ALIGN_RIGHT);
                        cellt.setBorder(BOTTOM);
                        table5.addCell(cellt);

                        phraset = new Phrase();
                        phraset.add(new Chunk(formatMysqltoDisplay(roundDoubleandFormat(totParzQuantity, 0)), f4_bold));
                        cellt = new PdfPCell(phraset);
                        cellt.setHorizontalAlignment(ALIGN_RIGHT);
                        cellt.setBorder(BOTTOM);
                        table5.addCell(cellt);

                        tot += totParz;
                        totQuantity += totParzQuantity;

                        phraset = new Phrase();
                        phraset.add(new Chunk(formatMysqltoDisplay(roundDoubleandFormat(totParz, 2)), f4_bold));
                        cellt = new PdfPCell(phraset);
                        cellt.setHorizontalAlignment(ALIGN_RIGHT);
                        cellt.setBorder(BOTTOM);
                        table5.addCell(cellt);

                        document.add(table5);

                    }
                    //linea totale  per utente
                    LineSeparator ls = new LineSeparator();
                    ls.setLineWidth(0.7f);
                    document.add(ls);

                    //linea totale utente
                }

                //Totale finale
                //linea totali
                PdfPTable table4 = new PdfPTable(colonne.size());
                table4.setWidths(columnWidths2);
                table4.setWidthPercentage(100);

                //linea totale per categoria
                LineSeparator ls = new LineSeparator();
                ls.setLineWidth(0.7f);
                document.add(ls);

                phraset = new Phrase();
                phraset.add(new Chunk("", f3_normal));
                cellt = new PdfPCell(phraset);
                cellt.setHorizontalAlignment(ALIGN_RIGHT);
                cellt.setBorder(BOTTOM);
                table4.addCell(cellt);

                phraset = new Phrase();
                phraset.add(new Chunk("", f3_normal));
                cellt = new PdfPCell(phraset);
                cellt.setHorizontalAlignment(ALIGN_RIGHT);
                cellt.setBorder(BOTTOM);
                table4.addCell(cellt);

                phraset = new Phrase();
                phraset.add(new Chunk("", f3_normal));
                cellt = new PdfPCell(phraset);
                cellt.setHorizontalAlignment(ALIGN_RIGHT);
                cellt.setBorder(BOTTOM);
                table4.addCell(cellt);

                phraset = new Phrase();
                phraset.add(new Chunk("", f3_normal));
                cellt = new PdfPCell(phraset);
                cellt.setHorizontalAlignment(ALIGN_RIGHT);
                cellt.setBorder(BOTTOM);
                table4.addCell(cellt);

                phraset = new Phrase();
                phraset.add(new Chunk("", f4_bold));
                cellt = new PdfPCell(phraset);
                cellt.setHorizontalAlignment(ALIGN_RIGHT);
                cellt.setBorder(BOTTOM);
                table4.addCell(cellt);

                phraset = new Phrase();
                phraset.add(new Chunk("Total from transaction listed", f4_bold));
                cellt = new PdfPCell(phraset);
                cellt.setHorizontalAlignment(ALIGN_LEFT);
                cellt.setBorder(BOTTOM);
                table4.addCell(cellt);

                phraset = new Phrase();
                phraset.add(new Chunk("", f3_normal));
                cellt = new PdfPCell(phraset);
                cellt.setHorizontalAlignment(ALIGN_RIGHT);
                cellt.setBorder(BOTTOM);
                table4.addCell(cellt);

                phraset = new Phrase();
                phraset.add(new Chunk(formatMysqltoDisplay(roundDoubleandFormat(totQuantity, 0)), f4_bold));
                cellt = new PdfPCell(phraset);
                cellt.setHorizontalAlignment(ALIGN_RIGHT);
                cellt.setBorder(BOTTOM);
                table4.addCell(cellt);

                phraset = new Phrase();
                phraset.add(new Chunk(formatMysqltoDisplay(roundDoubleandFormat(tot, 2)), f4_bold));
                cellt = new PdfPCell(phraset);
                cellt.setHorizontalAlignment(ALIGN_RIGHT);
                cellt.setBorder(BOTTOM);
                table4.addCell(cellt);

                document.add(table4);

                //linea totale
                ls.setLineWidth(0.7f);
                document.add(ls);
                //

                document.newPage();
            }

            document.close();
            wr.close();
            ou.close();
            String base64 = new String(encodeBase64(readFileToByteArray(pdf)));
            pdf.delete();
            return base64;
        } catch (IOException | DocumentException ex) {
            insertTR("E", "System", currentThread().getStackTrace()[1].getMethodName() + ": " + ex.getMessage());
        }
        return null;
    }

    /**
     *
     * @param path
     * @param nctllist
     * @param colonne
     * @param datereport1
     * @param datereport2
     * @return
     */
    public String receiptexcel(String path, ArrayList<NoChangeTransactionListForUser_value> nctllist, ArrayList<String> colonne, String datereport1, String datereport2) {

//        String outputfile = "NoChangeTransactionListForUser.pdf";
        try {
            File pdf = new File(normalize(path + generaId(50) + "NoChangeTransactionListForUser.xls"));
            HSSFWorkbook workbook = new HSSFWorkbook();

            //CREAZIONE FONT
            HSSFFont font = workbook.createFont();
            font.setFontName(FONT_ARIAL);
            font.setFontHeightInPoints((short) 12);
            font.setBold(true);

            HSSFCellStyle style1 = (HSSFCellStyle) workbook.createCellStyle();
            style1.setFont(font);

            HSSFFont font2 = workbook.createFont();
            font2.setFontName(FONT_ARIAL);
            font2.setFontHeightInPoints((short) 12);

            HSSFCellStyle style2 = (HSSFCellStyle) workbook.createCellStyle();
            style2.setFont(font2);

            HSSFFont font3 = workbook.createFont();
            font3.setFontName(FONT_ARIAL);
            font3.setFontHeightInPoints((short) 10);
            font3.setBold(true);

            HSSFCellStyle style3 = (HSSFCellStyle) workbook.createCellStyle();
            style3.setFont(font3);
            style3.setAlignment(RIGHT);
            style3.setBorderTop(THIN);
            style3.setBorderBottom(THIN);

            HSSFCellStyle style3left = (HSSFCellStyle) workbook.createCellStyle();
            style3left.setFont(font3);
            style3left.setAlignment(LEFT);
            style3left.setBorderTop(THIN);
            style3left.setBorderBottom(THIN);

            HSSFFont font4 = workbook.createFont();
            font4.setFontName(FONT_ARIAL);
            font4.setFontHeightInPoints((short) 10);

            HSSFCellStyle style4 = (HSSFCellStyle) workbook.createCellStyle();
            style4.setAlignment(RIGHT);
            style4.setBorderTop(THIN);
            style4.setBorderBottom(THIN);

            HSSFCellStyle style4left = (HSSFCellStyle) workbook.createCellStyle();
            style4left.setAlignment(LEFT);
            style4left.setBorderTop(THIN);
            style4left.setBorderBottom(THIN);

            for (int w = 0; w < nctllist.size(); w++) {

                NoChangeTransactionListForUser_value nctl = nctllist.get(w);

                HSSFSheet sheet = workbook.createSheet(nctl.getId_filiale());

                Row rowP = sheet.createRow((short) 1);

                Cell cl = rowP.createCell(1);
                cl.setCellStyle(style1);
                cl.setCellValue(intestazionePdf + " From " + datereport1 + " To " + datereport2);

//            Cell cl2 = rowP.createCell(6);
//            cl2.setCellStyle(style2);
//            cl2.setCellValue(datereport1);
                Row row = sheet.createRow((short) 3);
                row.createCell(1).setCellValue(nctl.getId_filiale() + " " + nctl.getDe_filiale());

                Row row66 = sheet.createRow((short) 7);

                int cntriga = 10;
                //mi scandisco le colonne
                for (int j = 0; j < colonne.size(); j++) {
                    Cell cl5 = row66.createCell(j + 1);
                    cl5.setCellStyle(style3);
                    if (j == 2 || j == 4 || j == 5 || j == 6) {
                        cl5.setCellStyle(style3left);
                    }
                    cl5.setCellValue(colonne.get(j));

                }

                //  document.add(table2);
                // document.add(sep);
                ArrayList<NoChangeTransactionListForUser_value> dati = nctl.getDati();

                ArrayList<String> user = new ArrayList<>();
                for (int x = 0; x < dati.size(); x++) {
                    NoChangeTransactionListForUser_value temp = dati.get(x);
                    if (!user.contains(temp.getUser())) {
                        user.add(temp.getUser());
                    }
                }

                double tot = 0;
                double totQuantity = 0;
                double totParz;
                double totParzQuantity;

                int numtranin = 0, numdeletran = 0, numtranout = 0, numtotaltran = 0;

                // scorro per utenti
                for (int n = 0; n < user.size(); n++) {

                    cntriga++;

                    Row row6bis = sheet.createRow((short) cntriga);
                    cntriga++;
                    cntriga++;

                    Users us = get_user(user.get(n));

                    Cell f1 = row6bis.createCell(2);
                    f1.setCellStyle(style3left);
                    f1.setCellValue(us.getCod() + " " + us.getDe_cognome() + " " + us.getDe_nome());

                    ArrayList<String> category = new ArrayList<>();
                    for (int x = 0; x < dati.size(); x++) {
                        NoChangeTransactionListForUser_value temp = (NoChangeTransactionListForUser_value) dati.get(x);
                        if (temp.getUser().equals(user.get(n))) {

                            if (!category.contains(temp.getCategoryTrans())) {
                                category.add(temp.getCategoryTrans());

                            }
                        }
                    }

                    for (int j = 0; j < category.size(); j++) {

                        totParz = 0;
                        totParzQuantity = 0;

                        for (int i = 0; i < dati.size(); i++) {

                            NoChangeTransactionListForUser_value temp = (NoChangeTransactionListForUser_value) dati.get(i);

                            if (temp.getUser().equals(user.get(n))) {

                                if (temp.getCategoryTrans().equals(category.get(j))) {

                                    cntriga++;
                                    cntriga++;
                                    Row row6 = sheet.createRow((short) cntriga);

                                    if (temp.getInout().equals("1") || temp.getInout().equals("3")) {
                                        numtranin++;
                                    } else if (temp.getInout().equals("2") || temp.getInout().equals("4")) {
                                        numtranout++;
                                    }

                                    if (temp.getAnnullato().equals("1")) {
                                        numdeletran++;
                                    } else {
                                        if(!temp.getKindTrans().toLowerCase().contains("acquisto") && !temp.getKindTrans().toLowerCase().contains("buy")){
                                            totParz += fd(formatDoubleforMysql(temp.getTotal()));
                                        }
                                        totParzQuantity += fd(formatDoubleforMysql(temp.getQuantity()));
                                    }

                                    if (temp.getAnnullato().equals("1")) {
                                        Cell f1bis = row6.createCell(1);
                                        f1bis.setCellStyle(style4);
                                        f1bis.setCellValue("D");
                                    }

                                    Cell f1bis = row6.createCell(2);
                                    f1bis.setCellStyle(style4);
                                    f1bis.setCellValue(temp.getUser());

                                    Cell f2 = row6.createCell(3);
                                    f2.setCellStyle(style4left);
                                    f2.setCellValue(temp.getCategoryTrans());

                                    Cell f3 = row6.createCell(4);
                                    f3.setCellStyle(style4);
                                    f3.setCellValue(temp.getTill());

                                    Cell f5 = row6.createCell(5);
                                    f5.setCellStyle(style4left);
                                    f5.setCellValue(temp.getDateTime());

                                    Cell f6 = row6.createCell(6);
                                    f6.setCellStyle(style4left);
                                    f6.setCellValue(temp.getKindTrans());

                                    Cell f7 = row6.createCell(7);
                                    f7.setCellStyle(style4left);
                                    f7.setCellValue(temp.getNote());

                                    Cell f8 = row6.createCell(8);
                                    f8.setCellStyle(style4);
                                    f8.setCellValue(temp.getQuantity());

                                    Cell f8bis = row6.createCell(9);
                                    f8bis.setCellStyle(style4);
                                    f8bis.setCellValue(temp.getTotal());

                                    //
                                    cntriga++;
                                    cntriga++;
                                }

//                            cntriga++;
                            }

                        }

                        Row row7 = sheet.createRow((short) cntriga);

                        Cell f18 = row7.createCell(7);
                        f18.setCellStyle(style3left);
                        f18.setCellValue("Total from transaction listed for category");

                        Cell f19 = row7.createCell(8);
                        f19.setCellStyle(style3);
                        f19.setCellValue(formatMysqltoDisplay(roundDoubleandFormat(totParzQuantity,0)) + "");

                        tot += totParz;
                        totQuantity += totParzQuantity;

                        Cell f20 = row7.createCell(9);
                        f20.setCellStyle(style3);
                        f20.setCellValue(formatMysqltoDisplay(roundDoubleandFormat(totParz, 2)));

                    }
                    cntriga++;

                }

                cntriga++;
                Row row7 = sheet.createRow((short) cntriga);

                Cell f18 = row7.createCell(7);
                f18.setCellStyle(style3);
                f18.setCellValue("Total from transaction listed");

                Cell f19 = row7.createCell(8);
                f19.setCellStyle(style3);
                f19.setCellValue(formatMysqltoDisplay(roundDoubleandFormat(totQuantity, 0)) + "");

                Cell f20 = row7.createCell(9);
                f20.setCellStyle(style3);
                f20.setCellValue(formatMysqltoDisplay(roundDoubleandFormat(tot, 2)));

                cntriga++;
                cntriga++;
                cntriga++;
                cntriga++;

                Row row777bis = sheet.createRow((short) cntriga);

                Cell f307 = row777bis.createCell(5);
                f307.setCellStyle(style3);
                f307.setCellValue("No. of Transaction In");

                Cell f3072 = row777bis.createCell(6);
                f3072.setCellStyle(style3);
                f3072.setCellValue("No. of Deleted Transaction");

                cntriga++;

                Row row777 = sheet.createRow((short) cntriga);

                Cell f30 = row777.createCell(5);
                f30.setCellStyle(style3);
                f30.setCellValue(valueOf(numtranin));

                Cell f301 = row777.createCell(6);
                f301.setCellStyle(style3);
                f301.setCellValue(valueOf(numdeletran));

                cntriga++;
                cntriga++;
                Row row888bis = sheet.createRow((short) cntriga);

                Cell f318 = row888bis.createCell(5);
                f318.setCellStyle(style3);
                f318.setCellValue("No. of Transaction Out");

                Cell f3182 = row888bis.createCell(6);
                f3182.setCellStyle(style3);
                f3182.setCellValue("No. of Total Transaction ");

                cntriga++;
                Row row888 = sheet.createRow((short) cntriga);

                Cell f31 = row888.createCell(5);
                f31.setCellStyle(style3);
                f31.setCellValue(valueOf(numtranout));

                Cell f312 = row888.createCell(6);
                f312.setCellStyle(style3);
                f312.setCellValue(valueOf(numtranin + numtranout - numdeletran));

                cntriga++;
                cntriga++;

                sheet.autoSizeColumn(0);
                sheet.autoSizeColumn(1);
                sheet.autoSizeColumn(2);
                sheet.autoSizeColumn(3);
                sheet.autoSizeColumn(4);
                sheet.autoSizeColumn(5);
                sheet.autoSizeColumn(6);
                sheet.autoSizeColumn(7);
                sheet.autoSizeColumn(8);
                sheet.autoSizeColumn(9);
                sheet.autoSizeColumn(10);
                sheet.autoSizeColumn(11);
                sheet.autoSizeColumn(12);
                sheet.autoSizeColumn(13);
                sheet.autoSizeColumn(14);

            }

            try (FileOutputStream out = new FileOutputStream(pdf)) {
                workbook.write(out);
            }
            String base64 = new String(encodeBase64(readFileToByteArray(pdf)));
            pdf.delete();
            return base64;
        } catch (IOException ex) {
            insertTR("E", "System", currentThread().getStackTrace()[1].getMethodName() + ": " + ex.getMessage());
        }
        return null;
    }

    //sistemare il footer e rendere i totali corretti
    private Phrase footer(String tot1, String tot2) {
        Font ffont = new Font(f3_normal);
        Phrase p = new Phrase("No. of Transaction In        " + tot1 + "         No. of Deleted Transaction      " + tot2 + " ", ffont);
        return p;
    }

    private Phrase footer2(String tot1, String tot2) {
        Font ffont = new Font(f3_normal);
        Phrase p = new Phrase("No. of Transaction Out      " + tot1 + "         No. of Total Transaction        " + tot2 + " ", ffont);
        return p;
    }

    // fine footer
}
