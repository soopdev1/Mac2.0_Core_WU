/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rc.so.report;

import java.util.ArrayList;

/**
 *
 * @author srotella
 */
public class InsuranceTransactionList_value {
    
    
    
    String id_filiale, de_filiale,dataDa,dataA,till,dateTime,categoryOfTransaction,InsuranceNumber, descr1, descr2, descr3, startDate, endDate, total, user,inout,annullato ;    
    
    ArrayList<InsuranceTransactionList_value> dati;

    /**
     *
     * @return
     */
    public String getInout() {
        return inout;
    }

    /**
     *
     * @param inout
     */
    public void setInout(String inout) {
        this.inout = inout;
    }

    /**
     *
     * @return
     */
    public String getAnnullato() {
        return annullato;
    }

    /**
     *
     * @param annullato
     */
    public void setAnnullato(String annullato) {
        this.annullato = annullato;
    }
    
    /**
     *
     * @return
     */
    public String getId_filiale() {
        return id_filiale;
    }

    /**
     *
     * @param id_filiale
     */
    public void setId_filiale(String id_filiale) {
        this.id_filiale = id_filiale;
    }

    /**
     *
     * @return
     */
    public String getDe_filiale() {
        return de_filiale;
    }

    /**
     *
     * @param de_filiale
     */
    public void setDe_filiale(String de_filiale) {
        this.de_filiale = de_filiale;
    }

    /**
     *
     * @return
     */
    public String getDataDa() {
        return dataDa;
    }

    /**
     *
     * @param dataDa
     */
    public void setDataDa(String dataDa) {
        this.dataDa = dataDa;
    }

    /**
     *
     * @return
     */
    public String getDataA() {
        return dataA;
    }

    /**
     *
     * @param dataA
     */
    public void setDataA(String dataA) {
        this.dataA = dataA;
    }

    /**
     *
     * @return
     */
    public String getTill() {
        return till;
    }

    /**
     *
     * @param till
     */
    public void setTill(String till) {
        this.till = till;
    }

    /**
     *
     * @return
     */
    public String getDateTime() {
        return dateTime;
    }

    /**
     *
     * @param dateTime
     */
    public void setDateTime(String dateTime) {
        this.dateTime = dateTime;
    }

    /**
     *
     * @return
     */
    public String getCategoryOfTransaction() {
        return categoryOfTransaction;
    }

    /**
     *
     * @param categoryOfTransaction
     */
    public void setCategoryOfTransaction(String categoryOfTransaction) {
        this.categoryOfTransaction = categoryOfTransaction;
    }

    /**
     *
     * @return
     */
    public String getInsuranceNumber() {
        return InsuranceNumber;
    }

    /**
     *
     * @param InsuranceNumber
     */
    public void setInsuranceNumber(String InsuranceNumber) {
        this.InsuranceNumber = InsuranceNumber;
    }

    /**
     *
     * @return
     */
    public String getDescr1() {
        return descr1;
    }

    /**
     *
     * @param descr1
     */
    public void setDescr1(String descr1) {
        this.descr1 = descr1;
    }

    /**
     *
     * @return
     */
    public String getDescr2() {
        return descr2;
    }

    /**
     *
     * @param descr2
     */
    public void setDescr2(String descr2) {
        this.descr2 = descr2;
    }

    /**
     *
     * @return
     */
    public String getDescr3() {
        return descr3;
    }

    /**
     *
     * @param descr3
     */
    public void setDescr3(String descr3) {
        this.descr3 = descr3;
    }

    /**
     *
     * @return
     */
    public String getStartDate() {
        return startDate;
    }

    /**
     *
     * @param startDate
     */
    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    /**
     *
     * @return
     */
    public String getEndDate() {
        return endDate;
    }

    /**
     *
     * @param endDate
     */
    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    /**
     *
     * @return
     */
    public String getTotal() {
        return total;
    }

    /**
     *
     * @param total
     */
    public void setTotal(String total) {
        this.total = total;
    }

    /**
     *
     * @return
     */
    public String getUser() {
        return user;
    }

    /**
     *
     * @param user
     */
    public void setUser(String user) {
        this.user = user;
    }

    /**
     *
     * @return
     */
    public ArrayList<InsuranceTransactionList_value> getDati() {
        return dati;
    }

    /**
     *
     * @param dati
     */
    public void setDati(ArrayList<InsuranceTransactionList_value> dati) {
        this.dati = dati;
    }

    
}
