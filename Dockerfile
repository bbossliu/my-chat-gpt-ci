# 第一阶段：使用Maven官方Java镜像作为基础镜像进行构建
FROM maven:3.6-jdk-11 AS build

# 复制源代码和pom.xml到容器中
COPY src /home/app/src
COPY pom.xml /home/app

# 设置工作目录
WORKDIR /home/app

# 执行Maven打包命令
RUN mvn clean package

# 第二阶段：使用Java运行时环境作为基础镜像
FROM openjdk:11-jre-slim

# 从构建阶段复制编译后的jar包到这个镜像的指定目录
COPY --from=build /home/app/target/chartgpt-service.jar /usr/app/chartgpt-service.jar

# 设置工作目录
WORKDIR /usr/app

# 暴露容器内的端口号
EXPOSE 8082

# 运行Java应用
CMD ["java", "-jar", "chartgpt-service.jar"]
