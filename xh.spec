%define name xh
%define version 0.21.0
%define release 1%{?dist}

Summary:  Friendly and fast tool for sending HTTP requests
Name:     %{name}
Version:  %{version}
Release:  %{release}
License:  MIT License
URL:      https://github.com/ducaale/xh
Source0:  https://github.com/ducaale/xh/archive/refs/tags/v%{version}.tar.gz

%define debug_package %{nil}

BuildRequires: curl
BuildRequires: gcc
BuildRequires: make

%description
xh is a friendly and fast tool for sending HTTP requests. It reimplements 
as much as possible of HTTPie's excellent design, with  a focus on improved performance.

%prep
%setup -q

%build
# Install Rust using curl
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
export PATH="$PATH:$HOME/.cargo/bin"
cargo build --release
strip --strip-all %{buildroot}%{_bindir}/*
# Install manpages
mkdir -p %{buildroot}%{_mandir}/man1/
# Install completions
mkdir -p %{buildroot}%{_mandir}/completions/
\rm completions/%{name}.ps1

%install
install -Dpm 0644 doc/%{name}*.1 -t %{buildroot}%{_mandir}/man1/
# Install shell completions
install -Dpm 0644 completions/_%{name} -t %{buildroot}%{_datadir}/zsh/site-functions/
install -Dpm 0644 completions/%{name}.bash %{buildroot}%{_datadir}/bash-completion/completions/%{name}
install -Dpm 0644 completions/%{name}.fish -t %{buildroot}/%{_datadir}/fish/vendor_completions.d/

%files
%license LICENSE
%doc README.md CHANGELOG.md
%{_bindir}/%{name}
%{_datadir}/bash-completion/completions/%{name}
%{_datadir}/fish/vendor_completions.d/%{name}.fish
%{_datadir}/zsh/site-functions/_%{name}
%{_mandir}/man1/*.1*
%dir %{_datadir}/fish
%dir %{_datadir}/fish/vendor_completions.d
%dir %{_datadir}/zsh
%dir %{_datadir}/zsh/site-functions

# Copy the binary to /bin in the buildroot
install -m 755 target/release/%{name} %{buildroot}/bin/

# Copy Bash completion
install -m 755 gen/completions/%{name}.bash %{buildroot}/etc/bash_completion.d/

# Copy the man page to /usr/share/man/man1 in the buildroot
gzip %{name}/%{name}.1
install -m 644 %{name}/%{name}.1.gz %{buildroot}/usr/share/man/man1/

%files
# List all the files to be included in the package
/bin/%{name}
/etc/bash_completion.d/%{name}.bash
/usr/share/man/man1/%{name}.1.gz

%changelog
* Tue Feb 27 2024 Danie de Jager - 0.21.0
- Initial RPM build
