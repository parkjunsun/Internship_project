package sptek.spdevteam.intern.common;

import org.springframework.stereotype.Component;

@Component
public class RandomOutUtil {

    public String getRandomStr() {
        char []tmp = new char[10];
        for(int i=0; i<tmp.length; i++) {
            int div = (int)Math.floor(Math.random() * 2);

            if(div == 0) {
                tmp[i] = (char)(Math.random()*10 + '0');
            } else {
                tmp[i] = (char)(Math.random()*26 + 'A');
            }
        }

        return new String(tmp);
    }

}
