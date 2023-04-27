package rc.so.util;

import org.xml.sax.ErrorHandler;
import org.xml.sax.SAXParseException;

/**
 *
 * @author rcosco
 */
public class SimpleErrorHandler
        implements ErrorHandler {

    /**
     *
     * @param e
     */
    @Override
    public void warning(SAXParseException e) {
//      System.err.println(e.getMessage());
    }

    /**
     *
     * @param e
     */
    @Override
    public void error(SAXParseException e) {
//    System.err.println(e.getMessage());
    }

    /**
     *
     * @param e
     */
    @Override
    public void fatalError(SAXParseException e) {
//    System.err.println(e.getMessage());
    }
}
