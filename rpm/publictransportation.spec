Name:       publictransportation
Summary:    Unified public transportation application
Version:    0.0.0
Release:    1
Group:      Applications/Internet
License:    BSD
URL:        https://github.com/SfietKonstantin/publictransportation
Source0:    %{name}-%{version}.tar.bz2
BuildRequires:  pkgconfig(Qt5Core)
BuildRequires:  pkgconfig(Qt5Qml)
BuildRequires:  pkgconfig(Qt5Quick)
BuildRequires:  pkgconfig(Qt5Gui)
BuildRequires:  pkgconfig(Qt5DBus)
BuildRequires:  pkgconfig(pt2)
Requires:  libpt2-qml-plugin
Requires:  sailfishsilica-qt5
Requires:  mapplauncherd-booster-silica-qt5
Requires:  mapplauncherd-qt5

%description
An unified public transportation application.

%package ts-devel
Summary:   Translation source for publictransportation
License:   BSD
Group:     System/Applications

%description ts-devel
Translation source for publictransportation.

%prep
%setup -q -n %{name}-%{version}

%build

%qmake5

make %{?jobs:-j%jobs}

%install
rm -rf %{buildroot}
%qmake5_install

desktop-file-install --delete-original       \
  --dir %{buildroot}%{_datadir}/applications             \
   %{buildroot}%{_datadir}/applications/*.desktop

%files
%defattr(-,root,root,-)
%{_datadir}/applications/*.desktop
%{_datadir}/publictransportation/*
%{_bindir}/publictransportation
%{_datadir}/translations/publictransportation_eng_en.qm

%files ts-devel
%defattr(-,root,root,-)
%{_datadir}/translations/source/publictransportation.ts
