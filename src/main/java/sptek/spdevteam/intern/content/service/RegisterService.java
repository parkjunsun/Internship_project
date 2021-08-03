package sptek.spdevteam.intern.content.service;

import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import sptek.spdevteam.intern.content.domain.Content;
import sptek.spdevteam.intern.content.domain.Image;
import sptek.spdevteam.intern.content.domain.SrcDto;

import java.util.HashMap;
import java.util.List;


public interface RegisterService {

    void ctnSave(Content content);

    void imgSave(Image image);

}
