%define name xh
%define version 0.24.0
%define release 2%{?dist}

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
BuildRequires: gzip

%description
xh is a friendly and fast tool for sending HTTP requests. It reimplements 
as much as possible of HTTPie's excellent design, with  a focus on improved performance.

%prep
%setup -q

%build
# Install Rust using curl
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
export PATH="$PATH:$HOME/.cargo/bin"
rustup install 1.87.0
rustup default 1.87.0
cargo build --release --locked
strip --strip-all target/release/%{name}
# Install manpages
mkdir -p %{buildroot}%{_mandir}/man1/
# Install completions
mkdir -p %{buildroot}%{_sysconfdir}
\rm completions/_%{name}.ps1
mkdir -p %{buildroot}%{_bindir}/
gzip doc/%{name}.1

%check
# Install Rust using curl
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
export PATH="$PATH:$HOME/.cargo/bin"
rustup install 1.87.0
rustup default 1.87.0
RUST_BACKTRACE=1 cargo test --release --locked

%install
install -Dpm 0755 target/release/%{name} %{buildroot}%{_bindir}/%{name}
install -Dpm 0644 doc/%{name}.1.gz -t %{buildroot}%{_mandir}/man1/
# Install shell completions
install -Dpm 0644 completions/_%{name} -t %{buildroot}/%{_sysconfdir}/zsh/site-functions/
install -Dpm 0644 completions/%{name}.bash %{buildroot}/%{_sysconfdir}/bash_completion.d/%{name}.bash
install -Dpm 0644 completions/%{name}.fish -t %{buildroot}/%{_sysconfdir}/fish/vendor_completions.d/

# Copy the binary to /bin in the buildroot
install -m 755 target/release/%{name} %{buildroot}/%{_bindir}/%{name}

%files
%license LICENSE
%doc README.md CHANGELOG.md
# List all the files to be included in the package
%{_bindir}/%{name}
%{_sysconfdir}/fish/vendor_completions.d/%{name}.fish
%{_sysconfdir}/zsh/site-functions/_%{name}
%{_sysconfdir}/bash_completion.d/%{name}.bash
%{_mandir}/man1/%{name}.1.gz

%changelog
* Wed Feb 26 2025 - Danie de Jager - 0.24.0-2
- Add testing
* Wed Feb 26 2025 - Danie de Jager - 0.24.0-1
* Thu Feb 6 2025 - Danie de Jager - 0.23.1-2
* Fri Jan 10 2025 - Danie de Jager - 0.23.1-1
* Mon Oct 14 2024 - Danie de Jager - 0.23.0-1
* Fri Sep 13 2024 - Danie de Jager - 0.22.2-2
* Tue Jul 9 2024 - Danie de Jager - 0.22.2-1
* Fri Apr 26 2024 - Danie de Jager - 0.22.0-2
* Sat Apr 13 2024 - Danie de Jager - 0.22.0-1
* Tue Feb 27 2024 - Danie de Jager - 0.21.0-1
- Initial RPM build
