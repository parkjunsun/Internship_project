package sptek.spdevteam.intern.common;


import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

public class ResizeImgUtil {

    private final String originalImg;
    private final String type;

    public ResizeImgUtil(String originalImg, String type) {
        this.originalImg = originalImg;
        this.type = type;
    }

    public BufferedImage resizeImg() throws IOException {
        BufferedImage findImg = ImageIO.read(new File(originalImg));
        int width = 0;
        int height = 0;

        if (type.equals("I0002")) {
            width = 400;
            height = 400;
        } else if (type.equals("I0003")) {
            width = 375;
            height = 225;
        }

        Image resizeImg = findImg.getScaledInstance(width, height, Image.SCALE_SMOOTH);
        BufferedImage newImg = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        Graphics g = newImg.getGraphics();
        g.drawImage(resizeImg, 0, 0, null);
        g.dispose();

        return newImg;
    }

}
