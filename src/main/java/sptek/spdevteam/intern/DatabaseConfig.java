package sptek.spdevteam.intern;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.jdbc.DataSourceBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import javax.sql.DataSource;

@Configuration
@MapperScan(basePackages="sptek.spdevteam.intern.*.mybatis")
@EnableTransactionManagement
public class DatabaseConfig {

    @Value("org.postgresql.Driver")
    private String dbDriverClassName;

    @Value("jdbc:postgresql://3.36.111.192:5432/sptekdb")
    private String dbJdbcUrl;

    @Value("sptek")
    private String dbUsername;

    @Value("passw0rd")
    private String dbPassword;

    @Bean
    public DataSource dataSource() {

        DataSourceBuilder dataSourceBuilder = DataSourceBuilder.create();

        dataSourceBuilder.driverClassName(dbDriverClassName);
        dataSourceBuilder.url(dbJdbcUrl);
        dataSourceBuilder.username(dbUsername);
        dataSourceBuilder.password(dbPassword);

        return dataSourceBuilder.build();
    }

    @Bean
    public SqlSessionFactory sqlSessionFactory(DataSource dataSource) throws Exception {
        final SqlSessionFactoryBean sessionFactory = new SqlSessionFactoryBean();
        sessionFactory.setDataSource(dataSource);
        PathMatchingResourcePatternResolver resolver = new PathMatchingResourcePatternResolver();
        sessionFactory.setMapperLocations(resolver.getResources("classpath:mybatis/*/*.xml"));
        return sessionFactory.getObject();
    }

    @Bean
    public SqlSessionTemplate sqlSessionTemplate(SqlSessionFactory sqlSessionFactory) throws Exception {
        final SqlSessionTemplate sqlSessionTemplate = new SqlSessionTemplate(sqlSessionFactory);
        return sqlSessionTemplate;
    }
}
