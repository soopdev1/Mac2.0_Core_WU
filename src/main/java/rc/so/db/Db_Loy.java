package rc.so.db;

import static rc.so.util.Constant.patternsqldate;
import static rc.so.util.Engine.insertTR;
import static java.lang.Class.forName;
import static java.lang.Thread.currentThread;
import java.sql.Connection;
import static java.sql.DriverManager.getConnection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import static java.sql.ResultSet.CONCUR_UPDATABLE;
import static java.sql.ResultSet.TYPE_SCROLL_INSENSITIVE;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Properties;
import org.joda.time.DateTime;
import static rc.so.util.Constant.rb;

/**
 *
 * @author rcosco
 */
public class Db_Loy {

    /**
     *
     */
    public Connection c = null;

    /**
     *
     * @return
     */
    public Connection getC() {
        return c;
    }

    /**
     *
     * @param c
     */
    public void setC(Connection c) {
        this.c = c;
    }

    /**
     ** Constructor
     */
    public Db_Loy() {
        try {
            String drivername = rb.getString("db.driver");
            String typedb = rb.getString("db.tipo");
            String user = "ssssssss";
            String pwd = "ssssssss";
            String host = rb.getString("db.ip") + "/loyalty";
            forName(drivername).newInstance();
            Properties p = new Properties();
            p.put("user", user);
            p.put("password", pwd);
            p.put("useUnicode", "true");
            p.put("characterEncoding", "UTF-8");
            p.put("useSSL", "false");
            p.put("connectTimeout", "1000");
            p.put("useUnicode", "true");
            p.put("useJDBCCompliantTimezoneShift", "true");
            p.put("useLegacyDatetimeCode", "false");
            p.put("serverTimezone", "Europe/Rome");
            this.c = getConnection("jdbc:" + typedb + ":" + host, p);
        } catch (Exception ex) {
            this.c = null;
        }
    }

    /**
     * close
     */
    public void closeDB() {
        try {
            if (this.c != null) {
                this.c.close();
            }
        } catch (Exception ex) {
            insertTR("E", "System", currentThread().getStackTrace()[1].getMethodName() + ": " + ex.getMessage());
        }
    }

    /**
     *
     * @param codloya
     * @return
     */
    public String getCodiceCliente_pub(String codloya) {
        try {
            String sql = "SELECT codcliente FROM mac_associate WHERE RIGHT(codloya,8) = ?";
            try ( PreparedStatement ps = this.c.prepareStatement(sql, TYPE_SCROLL_INSENSITIVE, CONCUR_UPDATABLE)) {
                ps.setString(1, codloya);
                try ( ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        return rs.getString(1);
                    }
                }
            }
        } catch (Exception ex) {
            insertTR("E", "System", currentThread().getStackTrace()[1].getMethodName() + ": " + ex.getMessage());
        }
        return null;
    }

    /**
     *
     * @param codloya
     * @return
     */
    public String getCodiceCliente(String codloya) {
        try {
            String sql = "SELECT codcliente FROM mac_associate WHERE codloya = ?";
            try ( PreparedStatement ps = this.c.prepareStatement(sql, TYPE_SCROLL_INSENSITIVE, CONCUR_UPDATABLE)) {
                ps.setString(1, codloya);
                try ( ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        return rs.getString(1);
                    }
                }
            }
        } catch (Exception ex) {
            insertTR("E", "System", currentThread().getStackTrace()[1].getMethodName() + ": " + ex.getMessage());
        }
        return null;

    }

    /**
     *
     * @param codloya
     * @param stato
     * @return
     */
    public String getCodiceCompleto(String codloya, String stato) {
        try {
            String sql = "SELECT codice FROM codici WHERE pubblico = ? AND stato = ?";
            try ( PreparedStatement ps = this.c.prepareStatement(sql, TYPE_SCROLL_INSENSITIVE, CONCUR_UPDATABLE)) {
                ps.setString(1, codloya);
                ps.setString(2, stato);
                try ( ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        return rs.getString(1);
                    }
                }
            }
        } catch (Exception ex) {
            insertTR("E", "System", currentThread().getStackTrace()[1].getMethodName() + ": " + ex.getMessage());
        }
        return null;
    }

    /**
     *
     * @param codloya
     * @return
     */
    public String[] getCodiceCompleto(String codloya) {
        try {
            String sql = "SELECT codice,stato FROM codici WHERE pubblico = ?";
            try ( PreparedStatement ps = this.c.prepareStatement(sql, TYPE_SCROLL_INSENSITIVE, CONCUR_UPDATABLE)) {
                ps.setString(1, codloya);
                try ( ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        String[] o = {rs.getString(1), rs.getString(2)};
                        return o;
                    }
                }
            }
        } catch (Exception ex) {
            insertTR("E", "System", currentThread().getStackTrace()[1].getMethodName() + ": " + ex.getMessage());

        }
        return null;
    }

    /**
     *
     * @param codcliente
     * @param codloya
     * @param stato
     * @return
     */
    public boolean update_mac_associate(String codcliente, String codloya, String stato) {
        try {
            String upd = "UPDATE mac_associate SET stato = ? WHERE codcliente = ? AND codloya = ?";
            try ( PreparedStatement ps = this.c.prepareStatement(upd, TYPE_SCROLL_INSENSITIVE, CONCUR_UPDATABLE)) {
                ps.setString(1, stato);
                ps.setString(2, codcliente);
                ps.setString(3, codloya);
                ps.executeUpdate();
            }
            return true;
        } catch (Exception ex) {
            insertTR("E", "System", currentThread().getStackTrace()[1].getMethodName() + ": " + ex.getMessage());

        }
        return false;
    }

    /**
     *
     * @param codloya
     * @param stato
     * @return
     */
    public boolean update_stato_codici(String codloya, String stato) {
        try {
            String upd = "UPDATE codici SET stato = ? WHERE codice = ?";
            try ( PreparedStatement ps = this.c.prepareStatement(upd, TYPE_SCROLL_INSENSITIVE, CONCUR_UPDATABLE)) {
                ps.setString(1, stato);
                ps.setString(2, codloya);
                ps.executeUpdate();
            }
            return true;
        } catch (Exception ex) {
            insertTR("E", "System", currentThread().getStackTrace()[1].getMethodName() + ": " + ex.getMessage());

        }
        return false;
    }

    /**
     *
     * @param codcliente
     * @param codloya
     * @return
     */
    public boolean ins_mac_associate(String codcliente, String codloya) {
        try {
            String ins = "INSERT INTO mac_associate (codcliente,codloya,data) VALUES (?,?,?)";
            try ( PreparedStatement ps = this.c.prepareStatement(ins, TYPE_SCROLL_INSENSITIVE, CONCUR_UPDATABLE)) {
                ps.setString(1, codcliente);
                ps.setString(2, codloya);
                ps.setString(3, new DateTime().toString(patternsqldate));
                ps.execute();
            }
            return true;
        } catch (Exception ex) {
            insertTR("E", "System", currentThread().getStackTrace()[1].getMethodName() + ": " + ex.getMessage());
            if (ex.getMessage().contains("Duplicate")) {
                return update_mac_associate(codcliente, codloya, "1");
            }
        }
        return false;
    }

    /**
     *
     * @param codcliente
     * @return
     */
    public String getCodiceClienteAttivo(String codcliente) {
        try {
            String sql = "SELECT RIGHT(codloya,8) FROM mac_associate WHERE codcliente = ? AND stato = ? ";
            try (PreparedStatement ps = this.c.prepareStatement(sql, TYPE_SCROLL_INSENSITIVE, CONCUR_UPDATABLE)) {
                ps.setString(1, codcliente);
                ps.setString(2, "1");
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        return rs.getString(1);
                    }
                }
            }
        } catch (Exception ex) {
            insertTR("E", "System", currentThread().getStackTrace()[1].getMethodName() + ": " + ex.getMessage());

        }
        return null;
    }

    /**
     *
     * @param codcliente
     * @return
     */
    public ArrayList<String[]> getListCodiciCliente(String codcliente) {
        try {
            ArrayList<String[]> str = new ArrayList<>();
            String sql = "SELECT RIGHT(codloya,8),stato FROM mac_associate WHERE codcliente = ? ORDER BY data DESC";
            try (PreparedStatement ps = this.c.prepareStatement(sql, TYPE_SCROLL_INSENSITIVE, CONCUR_UPDATABLE)) {
                ps.setString(1, codcliente);
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        String[] o1 = {rs.getString(1), rs.getString(2)};
                        str.add(o1);
                    }
                }
            }
            return str;
        } catch (Exception ex) {
            insertTR("E", "System", currentThread().getStackTrace()[1].getMethodName() + ": " + ex.getMessage());

        }
        return null;
    }

    /**
     *
     * @param codloya
     * @return
     */
    public boolean is_firsttransaction_cod(String codloya) {
        try {
            String sql = "select count(*) from mac_associate where codloya = ?";
            try (PreparedStatement ps = this.c.prepareStatement(sql, TYPE_SCROLL_INSENSITIVE, CONCUR_UPDATABLE)) {
                ps.setString(1, codloya);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        return rs.getInt(1) == 1;
                    }
                }
            }
        } catch (Exception ex) {
            insertTR("E", "System", currentThread().getStackTrace()[1].getMethodName() + ": " + ex.getMessage());
        }
        return false;
    }

    /**
     *
     * @param codcliente
     * @return
     */
    public boolean is_firsttransaction(String codcliente) {
        try {
            String sql = "select count(*) from mac_associate where codcliente = ?";
            try (PreparedStatement ps = this.c.prepareStatement(sql, TYPE_SCROLL_INSENSITIVE, CONCUR_UPDATABLE)) {
                ps.setString(1, codcliente);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        return rs.getInt(1) == 1;
                    }
                }
            }
        } catch (SQLException ex) {
            insertTR("E", "System", currentThread().getStackTrace()[1].getMethodName() + ": " + ex.getMessage());
        }
        return false;
    }

    /**
     *
     * @param codcliente
     * @param stato
     * @return
     */
    public boolean set_stato_associaz_cliente(String codcliente, String stato) {
        try {
            String sql = "UPDATE mac_associate SET stato = ? WHERE codcliente = ?";
            PreparedStatement ps = this.c.prepareStatement(sql, TYPE_SCROLL_INSENSITIVE, CONCUR_UPDATABLE);
            ps.setString(1, stato);
            ps.setString(2, codcliente);
            return ps.executeUpdate() > 0;
        } catch (SQLException ex) {
            insertTR("E", "System", currentThread().getStackTrace()[1].getMethodName() + ": " + ex.getMessage());

        }
        return false;
    }

    /**
     *
     * @param codcliente
     * @param codloya
     * @return
     */
    public boolean remove_mac_associate(String codcliente, String codloya) {
        try {
            String ins = "DELETE FROM mac_associate WHERE codcliente = ? AND codloya = ?";
            PreparedStatement ps = this.c.prepareStatement(ins, TYPE_SCROLL_INSENSITIVE, CONCUR_UPDATABLE);
            ps.setString(1, codcliente);
            ps.setString(2, codloya);
            ps.execute();
            return true;
        } catch (SQLException ex) {
            insertTR("E", "System", currentThread().getStackTrace()[1].getMethodName() + ": " + ex.getMessage());
        }
        return false;
    }

}
