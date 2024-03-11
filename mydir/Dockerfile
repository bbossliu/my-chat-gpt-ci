# 使用Maven官方Java镜像作为基础镜像
FROM maven:3.6-jdk-11

# 复制pom.xml和源代码到容器中
COPY src /home/app/src
COPY pom.xml /home/app

# 执行Maven打包命令
RUN mvn -f /home/app/pom.xml clean package

# 设置工作目录
WORKDIR /home/app

# 复制编译后的jar包到docker镜像指定目录
COPY --from=maven /home/app/target/chartgpt-service.jar /usr/app/chartgpt-service.jar

# 暴露容器内的端口号
EXPOSE 8082

# 运行Java应用
CMD ["java", "-jar", "/usr/app/your-app.jar"]