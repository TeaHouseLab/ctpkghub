#!/usr/bin/fish
mkdir built/ &>/dev/null
set packages (ls | sed '\~//~d')
for _packages_ in $packages
    if [ "$_packages_" = "builder.sh" ]
    else
        if [ "$_packages_" = "built" ]
        else
            cd $_packages_
            set package_relver (sed -n '/package_relver=/'p ctpm_pkg_info | sed 's/package_relver=//g')
            harulake pack
            mv *.ctpkg ../built/
            cd ..
            echo $_packages_=$package_relver >> list
        end
    end
end
mv list built/
cd built
gh release upload ctpm * --clobber
