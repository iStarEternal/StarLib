
//.h文件
#define SingletonH(name) \
+(instancetype) shared##name ;

//.m文件
#define SingletonM(name) \
static id instance##name; \
+(instancetype) shared##name { \
    return [[self allocWithZone:nil]init]; \
} \
+(instancetype)allocWithZone:(struct _NSZone *)zone{ \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        instance##name = [super allocWithZone:zone]; \
    }); \
    return instance##name; \
} \
+(instancetype)alloc { \
    return [self allocWithZone:nil];\
}

