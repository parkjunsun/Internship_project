package sptek.spdevteam.intern.content.service;

import sptek.spdevteam.intern.content.domain.ListDomain;
import sptek.spdevteam.intern.content.domain.TempType;

import java.util.List;

public interface ListService {
    public List<TempType> getTempList() throws Exception;
}
