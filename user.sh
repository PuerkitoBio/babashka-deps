# add_user $1:user_name
add_user() {
    user_name="$1"

    function is_met() {
        id -u "${user_name}" > /dev/null 2>&1
    }
    function meet() {
        adduser --disabled-password --gecos "" "${user_name}"
    }
    process
}

add_test_user() {
    add_user testu
}
