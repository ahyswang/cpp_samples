# CMake ��Ͱ汾��Ҫ��
cmake_minimum_required (VERSION 2.8)
# ��Ŀ��Ϣ
project (demo5)

# ���ð汾��
set (Demo_VERSION_MAJOR 1)
set (Demo_VERSION_MINOR 0)


# ���ϵͳ�Ƿ�֧�� pow ����
include (${CMAKE_ROOT}/Modules/CheckFunctionExists.cmake)
check_function_exists (pow HAVE_POW)

# ����һ������ͷ�ļ������ڴ���cmake��Դ�������
configure_file (
	"${PROJECT_SOURCE_DIR}/config.h.in"
	"${PROJECT_BINARY_DIR}/config.h"
)

# �Ƿ�ʹ���Լ���math��
option (USE_MYMATH
		"Use provided math implementation" ON)

include_directories ("${PROJECT_BINARY_DIR}")
 
# �Ƿ����math��
if (USE_MYMATH)
	include_directories ("${PROJECT_SOURCE_DIR}/math")
	add_subdirectory(math)
	set (EXTRA_LIBS ${EXTRA_LIBS} math)
endif (USE_MYMATH)

# ���ҵ�ǰĿ¼�µ�����Դ�ļ�
aux_source_directory(. SRCS)

# ָ������Ŀ��
add_executable(demo5 main.cpp)
# �������ӿ�
target_link_libraries(demo5 ${EXTRA_LIBS})

# ���ð�װ·��
#set (CMAKE_INSTALL_PREFIX /tmp/demo5)
# ָ����װ·��
install (TARGETS demo5 DESTINATION bin)
install (FILES "${PROJECT_BINARY_DIR}/config.h"
         DESTINATION include)

# ���ò���
enable_testing()
# ���Գ����Ƿ�ɹ�����
# ���� 5 ��ƽ��
add_test (test_5_2 demo5 5 2)
set_tests_properties (test_5_2
 PROPERTIES PASS_REGULAR_EXPRESSION "is 25")

 # ����һ���꣬�����򻯲��Թ���
 macro (do_test arg1 arg2 result)
	add_test(test_${arg1}_${arg2} demo5 ${arg1} ${arg2})
	set_tests_properties(test_${arg1}_${arg2}
		PROPERTIES PASS_REGULAR_EXPRESSION ${result})
 endmacro (do_test)

 do_test (5 2 "is 25")
 do_test (10 5 "is 100000")
 do_test (2 10 "is 1024")