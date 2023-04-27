/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rc.so.entity;

/**
 *
 * @author rcosco
 */
public class BCE {

    String data, valuta;
    double rif_bce;

    /**
     *
     * @param data
     * @param valuta
     * @param rif_bce
     */
    public BCE(String data, String valuta, double rif_bce) {
        this.data = data;
        this.valuta = valuta;
        this.rif_bce = rif_bce;
    }
    
    /**
     *
     * @return
     */
    public String getData() {
        return data;
    }

    /**
     *
     * @param data
     */
    public void setData(String data) {
        this.data = data;
    }

    /**
     *
     * @return
     */
    public String getValuta() {
        return valuta;
    }

    /**
     *
     * @param valuta
     */
    public void setValuta(String valuta) {
        this.valuta = valuta;
    }

    /**
     *
     * @return
     */
    public double getRif_bce() {
        return rif_bce;
    }

    /**
     *
     * @param rif_bce
     */
    public void setRif_bce(double rif_bce) {
        this.rif_bce = rif_bce;
    }
    
    
    
}
