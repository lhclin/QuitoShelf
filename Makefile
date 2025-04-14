# Modify OPENSCAD, SRC, DEST. Then do a make clean; make -j

OPENSCAD=/usr/bin/openscad
SRC=
DEST=

DESTSHELVES=$(DEST)/Shelves
DESTPLATES=$(DEST)/Plates
DESTEQUIPMENTPLATES=$(DEST)/EquipmentPlates
DESTACCESSORIES=$(DEST)/Accessories

all: shelves accessories plates

# -------
# Shelves
# -------

$(DESTSHELVES)/Shelf40mmSlim.stl: $(SRC)/Shelf.scad $(SRC)/Common.scad 
	echo "Rendering 40mm Slim Shelf..."
	$(OPENSCAD) -o $(DESTSHELVES)/Shelf40mmSlim.stl -D 'Height="40mm Slim"' $(SRC)/Shelf.scad
	echo "Done 40mm Slim Shelf"

$(DESTSHELVES)/Shelf50mmStandard.stl: $(SRC)/Shelf.scad $(SRC)/Common.scad
	echo "Rendering 50mm Standard Shelf..."
	$(OPENSCAD) -o $(DESTSHELVES)/Shelf50mmStandard.stl -D 'Height="50mm Standard"' $(SRC)/Shelf.scad
	echo "Done 50mm Standard Shelf"

$(DESTSHELVES)/Shelf150mm.stl: $(SRC)/Shelf.scad $(SRC)/Common.scad
	echo "Rendering 150mm Shelf..."
	$(OPENSCAD) -o $(DESTSHELVES)/Shelf150mm.stl -D 'Height="150mm"' $(SRC)/Shelf.scad
	echo "Done 150mm Shelf"

$(DESTSHELVES)/Shelf180mm.stl: $(SRC)/Shelf.scad $(SRC)/Common.scad
	echo "Rendering 180mm Shelf..."
	$(OPENSCAD) -o $(DESTSHELVES)/Shelf180mm.stl -D 'Height="180mm"' $(SRC)/Shelf.scad
	echo "Done 180mm Shelf"

$(DESTSHELVES)/Shelf150mmBraceless.stl: $(SRC)/Shelf.scad $(SRC)/Common.scad
	echo "Rendering 150mm Braceless Shelf..."
	$(OPENSCAD) -o $(DESTSHELVES)/Shelf150mmBraceless.stl -D 'Height="150mm"' -D 'Cross_Brace=false' $(SRC)/Shelf.scad
	echo "Done 150mm Braceless Shelf"

$(DESTSHELVES)/Shelf180mmBraceless.stl: $(SRC)/Shelf.scad $(SRC)/Common.scad
	echo "Rendering 180mm Braceless Shelf..."
	$(OPENSCAD) -o $(DESTSHELVES)/Shelf180mmBraceless.stl -D 'Height="180mm"' -D 'Cross_Brace=false' $(SRC)/Shelf.scad
	echo "Done 180mm BracelessShelf"

# -----------
# Accessories
# -----------

$(DESTACCESSORIES)/TopCover.stl: $(SRC)/Shelf.scad $(SRC)/Common.scad
	echo "Rendering Top Cover..."
	$(OPENSCAD) -o $(DESTACCESSORIES)/TopCover.stl -D 'Making="Top Cover"' $(SRC)/Shelf.scad
	echo "Done Top Cover"

$(DESTACCESSORIES)/TopCoverShort.stl: $(SRC)/Shelf.scad $(SRC)/Common.scad
	echo "Rendering Short Top Cover..."
	$(OPENSCAD) -o $(DESTACCESSORIES)/TopCoverShort.stl -D 'Making="Short Top Cover"' $(SRC)/Shelf.scad
	echo "Done Short Top Cover"

$(DESTACCESSORIES)/PlateStoppers.stl: $(SRC)/Accessories.scad $(SRC)/Common.scad $(SRC)/threads.scad
	echo "Rendering Plate Stoppers..."
	$(OPENSCAD) -o $(DESTACCESSORIES)/PlateStoppers.stl -D 'Making="Plate Stoppers"' $(SRC)/Accessories.scad
	echo "Done Plate Stoppers"

$(DESTACCESSORIES)/SideClipBackSlim.stl: $(SRC)/Accessories.scad $(SRC)/Common.scad $(SRC)/threads.scad
	echo "Rendering Side Clip Back Slim..."
	$(OPENSCAD) -o $(DESTACCESSORIES)/SideClipBackSlim.stl -D 'Making="Side Clip Back Slim"' $(SRC)/Accessories.scad
	echo "Done Side Clip Back Slim"

$(DESTACCESSORIES)/SideClipBackStandard.stl: $(SRC)/Accessories.scad $(SRC)/Common.scad $(SRC)/threads.scad
	echo "Rendering Side Clip Back Standard..."
	$(OPENSCAD) -o $(DESTACCESSORIES)/SideClipBackStandard.stl -D 'Making="Side Clip Back Standard"' $(SRC)/Accessories.scad
	echo "Done Side Clip Back Standard"

$(DESTACCESSORIES)/SideClipsAirVent.stl: $(SRC)/Accessories.scad $(SRC)/Common.scad $(SRC)/threads.scad
	echo "Rendering Side Clip Air Vent..."
	$(OPENSCAD) -o $(DESTACCESSORIES)/SideClipsAirVent.stl -D 'Making="Side Clips Air Vent"' $(SRC)/Accessories.scad
	echo "Done Side Clips Air Vent"

$(DESTACCESSORIES)/MountingScrew25mm.stl: $(SRC)/Accessories.scad $(SRC)/Common.scad $(SRC)/threads.scad
	echo "Rendering Mounting Screw 25mm..."
	$(OPENSCAD) -o $(DESTACCESSORIES)/MountingScrew25mm.stl -D 'Making="Mounting Screw 25mm"' $(SRC)/Accessories.scad
	echo "Done Mounting Screw 25mm..."

$(DESTACCESSORIES)/MountingScrew40mm.stl: $(SRC)/Accessories.scad $(SRC)/Common.scad $(SRC)/threads.scad
	echo "Rendering Mounting Screw 40mm..."
	$(OPENSCAD) -o $(DESTACCESSORIES)/MountingScrew40mm.stl -D 'Making="Mounting Screw 40mm"' $(SRC)/Accessories.scad
	echo "Done Mounting Screw 40mm..."

# -----------
# Base Plates
# -----------

$(DESTPLATES)/VentedPlate.stl: $(SRC)/QuickReleaseBasePlate.scad $(SRC)/Common.scad $(SRC)/KeystoneMount.scad
	echo "Rendering Vented Plate..."
	$(OPENSCAD) -o $(DESTPLATES)/VentedPlate.stl -D 'Making="Vented"' $(SRC)/QuickReleaseBasePlate.scad
	echo "Done Vented Plate"

$(DESTPLATES)/SolidFullPlate.stl: $(SRC)/QuickReleaseBasePlate.scad $(SRC)/Common.scad $(SRC)/KeystoneMount.scad
	echo "Rendering Solid Full Plate..."
	$(OPENSCAD) -o $(DESTPLATES)/SolidFullPlate.stl -D 'Making="Solid Full"' $(SRC)/QuickReleaseBasePlate.scad
	echo "Done Solid Full Plate"

$(DESTPLATES)/SolidHalfPlate.stl: $(SRC)/QuickReleaseBasePlate.scad $(SRC)/Common.scad $(SRC)/KeystoneMount.scad
	echo "Rendering Solid Half Plate..."
	$(OPENSCAD) -o $(DESTPLATES)/SolidHalfPlate.stl -D 'Making="Solid Half"' $(SRC)/QuickReleaseBasePlate.scad
	echo "Done Solid Half Plate"

$(DESTPLATES)/SolidQuarterPlate.stl: $(SRC)/QuickReleaseBasePlate.scad $(SRC)/Common.scad $(SRC)/KeystoneMount.scad
	echo "Rendering Solid Quarter Plate..."
	$(OPENSCAD) -o $(DESTPLATES)/SolidQuarterPlate.stl -D 'Making="Solid Quarter"' $(SRC)/QuickReleaseBasePlate.scad
	echo "Done Solid Quarter Plate"

$(DESTPLATES)/DrawerStandard.stl: $(SRC)/QuickReleaseBasePlate.scad $(SRC)/Common.scad $(SRC)/KeystoneMount.scad
	echo "Rendering Standard Drawer..."
	$(OPENSCAD) -o $(DESTPLATES)/DrawerStandard.stl -D 'Making="Drawer"' -D 'Height="50mm Standard"' $(SRC)/QuickReleaseBasePlate.scad
	echo "Done Standard Drawer"

$(DESTPLATES)/DrawerSlim.stl: $(SRC)/QuickReleaseBasePlate.scad $(SRC)/Common.scad $(SRC)/KeystoneMount.scad
	echo "Rendering Slim Drawer..."
	$(OPENSCAD) -o $(DESTPLATES)/DrawerSlim.stl -D 'Making="Drawer"' -D 'Height="40mm Slim"' $(SRC)/QuickReleaseBasePlate.scad
	echo "Done Slim Drawer"

$(DESTPLATES)/8KeystonesStandard.stl: $(SRC)/QuickReleaseBasePlate.scad $(SRC)/Common.scad $(SRC)/KeystoneMount.scad
	echo "Rendering Standard 8 Keystones Plate..."
	$(OPENSCAD) -o $(DESTPLATES)/8KeystonesStandard.stl -D 'Making="Keystones"' -D 'Height="50mm Standard"' -D 'Keystones=8' $(SRC)/QuickReleaseBasePlate.scad
	echo "Done Standard 8 Keystones Plate"

$(DESTPLATES)/8KeystonesSlim.stl: $(SRC)/QuickReleaseBasePlate.scad $(SRC)/Common.scad $(SRC)/KeystoneMount.scad
	echo "Rendering Slim 8 Keystones Plate..."
	$(OPENSCAD) -o $(DESTPLATES)/8KeystonesSlim.stl -D 'Making="Keystones"' -D 'Height="40mm Slim"' -D 'Keystones=8' $(SRC)/QuickReleaseBasePlate.scad
	echo "Done Slim 8 Keystones Plate"

$(DESTPLATES)/12KeystonesStandard.stl: $(SRC)/QuickReleaseBasePlate.scad $(SRC)/Common.scad $(SRC)/KeystoneMount.scad
	echo "Rendering Standard 12 Keystones Plate..."
	$(OPENSCAD) -o $(DESTPLATES)/12KeystonesStandard.stl -D 'Making="Keystones"' -D 'Height="50mm Standard"' -D 'Keystones=12' $(SRC)/QuickReleaseBasePlate.scad
	echo "Done Standard 12 Keystones Plate"

$(DESTPLATES)/12KeystonesSlim.stl: $(SRC)/QuickReleaseBasePlate.scad $(SRC)/Common.scad $(SRC)/KeystoneMount.scad
	echo "Rendering Slim 12 Keystones Plate..."
	$(OPENSCAD) -o $(DESTPLATES)/12KeystonesSlim.stl -D 'Making="Keystones"' -D 'Height="40mm Slim"' -D 'Keystones=12' $(SRC)/QuickReleaseBasePlate.scad
	echo "Done Slim 12 Keystones Plate"

# ----------------------
# Universal Mount Plates
# ----------------------
$(DESTPLATES)/UniversalSideScrews120mmStandard.stl: $(SRC)/QuickReleaseBasePlate.scad $(SRC)/QuickReleaseUniversalPlate.scad $(SRC)/Common.scad $(SRC)/threads.scad
	echo "Rendering Standard UM 120mm SS Plate..."
	$(OPENSCAD) -o $(DESTPLATES)/UniversalSideScrews120mmStandard.stl -D 'Making="Side Screw"' -D 'Shelf_Height="50mm Standard"' -D 'Equipment_Width=120' $(SRC)/QuickReleaseUniversalPlate.scad
	echo "Done Standard UM 120mm SS Plate"

$(DESTPLATES)/UniversalSideScrews145mmStandard.stl: $(SRC)/QuickReleaseBasePlate.scad $(SRC)/QuickReleaseUniversalPlate.scad $(SRC)/Common.scad $(SRC)/threads.scad
	echo "Rendering Standard UM 145mm SS Plate..."
	$(OPENSCAD) -o $(DESTPLATES)/UniversalSideScrews145mmStandard.stl -D 'Making="Side Screw"' -D 'Shelf_Height="50mm Standard"' -D 'Equipment_Width=145' $(SRC)/QuickReleaseUniversalPlate.scad
	echo "Done Standard UM 145mm SS Plate"

$(DESTPLATES)/UniversalSideScrews170mmStandard.stl: $(SRC)/QuickReleaseBasePlate.scad $(SRC)/QuickReleaseUniversalPlate.scad $(SRC)/Common.scad $(SRC)/threads.scad
	echo "Rendering Standard UM 170mm SS Plate..."
	$(OPENSCAD) -o $(DESTPLATES)/UniversalSideScrews170mmStandard.stl -D 'Making="Side Screw"' -D 'Shelf_Height="50mm Standard"' -D 'Equipment_Width=170' $(SRC)/QuickReleaseUniversalPlate.scad
	echo "Done Standard UM 170mm SS Plate"

$(DESTPLATES)/UniversalSideScrews120mmSlim.stl: $(SRC)/QuickReleaseBasePlate.scad $(SRC)/QuickReleaseUniversalPlate.scad $(SRC)/Common.scad $(SRC)/threads.scad
	echo "Rendering Slim UM 120mm SS Plate..."
	$(OPENSCAD) -o $(DESTPLATES)/UniversalSideScrews120mmSlim.stl -D 'Making="Side Screw"' -D 'Shelf_Height="40mm Slim"' -D 'Equipment_Width=120' $(SRC)/QuickReleaseUniversalPlate.scad
	echo "Done Slim UM 120mm SS Plate"

$(DESTPLATES)/UniversalSideScrews145mmSlim.stl: $(SRC)/QuickReleaseBasePlate.scad $(SRC)/QuickReleaseUniversalPlate.scad $(SRC)/Common.scad $(SRC)/threads.scad
	echo "Rendering Slim UM 145mm SS Plate..."
	$(OPENSCAD) -o $(DESTPLATES)/UniversalSideScrews145mmSlim.stl -D 'Making="Side Screw"' -D 'Shelf_Height="40mm Slim"' -D 'Equipment_Width=145' $(SRC)/QuickReleaseUniversalPlate.scad
	echo "Done Slim UM 145mm SS Plate"

$(DESTPLATES)/UniversalSideScrews170mmSlim.stl: $(SRC)/QuickReleaseBasePlate.scad $(SRC)/QuickReleaseUniversalPlate.scad $(SRC)/Common.scad $(SRC)/threads.scad
	echo "Rendering Slim UM 170mm SS Plate..."
	$(OPENSCAD) -o $(DESTPLATES)/UniversalSideScrews170mmSlim.stl -D 'Making="Side Screw"' -D 'Shelf_Height="40mm Slim"' -D 'Equipment_Width=170' $(SRC)/QuickReleaseUniversalPlate.scad
	echo "Done Slim UM 170mm SS Plate"

$(DESTPLATES)/UniversalBackScrews180mm-2Standard.stl: $(SRC)/QuickReleaseBasePlate.scad $(SRC)/QuickReleaseUniversalPlate.scad $(SRC)/Common.scad $(SRC)/threads.scad
	echo "Rendering Standard UM 180mm-2 BS Plate..."
	$(OPENSCAD) -o $(DESTPLATES)/UniversalBackScrews180mm-2Standard.stl -D 'Making="Back Screw"' -D 'Shelf_Height="50mm Standard"' -D 'Equipment_Width=180' -D 'Back_Screw_Plate_Position=2' $(SRC)/QuickReleaseUniversalPlate.scad
	echo "Done Standard UM 180mm-2 BS Plate"

$(DESTPLATES)/UniversalBackScrews180mm-2Slim.stl: $(SRC)/QuickReleaseBasePlate.scad $(SRC)/QuickReleaseUniversalPlate.scad $(SRC)/Common.scad $(SRC)/threads.scad
	echo "Rendering Slim UM 180mm-2 BS Plate..."
	$(OPENSCAD) -o $(DESTPLATES)/UniversalBackScrews180mm-2Slim.stl -D 'Making="Back Screw"' -D 'Shelf_Height="40mm Slim"' -D 'Equipment_Width=180' -D 'Back_Screw_Plate_Position=2' $(SRC)/QuickReleaseUniversalPlate.scad
	echo "Done Slim UM 180mm-2 BS Plate"

$(DESTPLATES)/UniversalBackScrewsWide-2Standard.stl: $(SRC)/QuickReleaseBasePlate.scad $(SRC)/QuickReleaseUniversalPlate.scad $(SRC)/Common.scad $(SRC)/threads.scad
	echo "Rendering Standard UM Wide-2 BS Plate..."
	$(OPENSCAD) -o $(DESTPLATES)/UniversalBackScrewsWide-2Standard.stl -D 'Making="Back Screw"' -D 'Shelf_Height="50mm Standard"' -D 'Equipment_Width=200' -D 'Back_Screw_Plate_Position=2' $(SRC)/QuickReleaseUniversalPlate.scad
	echo "Done Standard UM Wide-2 BS Plate"

$(DESTPLATES)/UniversalBackScrewsWide-2Slim.stl: $(SRC)/QuickReleaseBasePlate.scad $(SRC)/QuickReleaseUniversalPlate.scad $(SRC)/Common.scad $(SRC)/threads.scad
	echo "Rendering Slim UM Wide-2 BS Plate..."
	$(OPENSCAD) -o $(DESTPLATES)/UniversalBackScrewsWide-2Slim.stl -D 'Making="Back Screw"' -D 'Shelf_Height="40mm Slim"' -D 'Equipment_Width=200' -D 'Back_Screw_Plate_Position=2' $(SRC)/QuickReleaseUniversalPlate.scad
	echo "Done Slim UM Wide-2 BS Plate"

# -------------------------
# Equipment Specific Plates
# -------------------------
$(DESTEQUIPMENTPLATES)/HPElitedeskMiniStandardPlate.stl: $(SRC)/QuickReleaseBasePlate.scad $(SRC)/QuickReleaseUniversalPlate.scad $(SRC)/QuickReleaseEquipmentPlate.scad $(SRC)/Common.scad $(SRC)/KeystoneMount.scad
	echo "Rendering HP Elitedesk Mini Plate..."
	$(OPENSCAD) -o $(DESTEQUIPMENTPLATES)/HPElitedeskMiniStandardPlate.stl -D 'Making="HP Elitedesk Mini"' $(SRC)/QuickReleaseEquipmentPlate.scad
	echo "Done HP Elitedesk Mini Plate"

$(DESTEQUIPMENTPLATES)/YuLinca8PortSlimPlate.stl: $(SRC)/QuickReleaseBasePlate.scad $(SRC)/QuickReleaseUniversalPlate.scad $(SRC)/QuickReleaseEquipmentPlate.scad $(SRC)/Common.scad $(SRC)/KeystoneMount.scad
	echo "Rendering YuLinca 8 Port Plate..."
	$(OPENSCAD) -o $(DESTEQUIPMENTPLATES)/YuLinca8PortSlimPlate.stl -D 'Making="YuLinca 8 port Network Switch"' $(SRC)/QuickReleaseEquipmentPlate.scad
	echo "Done HP Yulinca 8 Port Plate"

$(DESTEQUIPMENTPLATES)/TPLinkTLSG1008DPlate.stl: $(SRC)/QuickReleaseBasePlate.scad $(SRC)/QuickReleaseUniversalPlate.scad $(SRC)/QuickReleaseEquipmentPlate.scad $(SRC)/Common.scad $(SRC)/KeystoneMount.scad
	echo "Rendering TPLinkTLSG1008D Plate..."
	$(OPENSCAD) -o $(DESTEQUIPMENTPLATES)/TPLinkTLSG1008DPlate.stl -D 'Making="TP-Link TLSG1008D"' $(SRC)/QuickReleaseEquipmentPlate.scad
	echo "Done TPLinkTLSG1008D Plate"

$(DESTEQUIPMENTPLATES)/NetgearGS208Plate.stl: $(SRC)/QuickReleaseBasePlate.scad $(SRC)/QuickReleaseUniversalPlate.scad $(SRC)/QuickReleaseEquipmentPlate.scad $(SRC)/Common.scad $(SRC)/KeystoneMount.scad
	echo "Rendering Netgear GS208 Plate..."
	$(OPENSCAD) -o $(DESTEQUIPMENTPLATES)/NetgearGS208Plate.stl -D 'Making="Netgear GS208"' $(SRC)/QuickReleaseEquipmentPlate.scad
	echo "Done Netgear GS208 Plate"

shelves: \
    $(DESTSHELVES)/Shelf40mmSlim.stl \
    $(DESTSHELVES)/Shelf50mmStandard.stl \
    $(DESTSHELVES)/Shelf150mm.stl \
    $(DESTSHELVES)/Shelf180mm.stl \
    $(DESTSHELVES)/Shelf150mmBraceless.stl \
    $(DESTSHELVES)/Shelf180mmBraceless.stl

accessories: \
    $(DESTACCESSORIES)/TopCover.stl \
    $(DESTACCESSORIES)/TopCoverShort.stl \
    $(DESTACCESSORIES)/PlateStoppers.stl \
    $(DESTACCESSORIES)/SideClipBackSlim.stl \
    $(DESTACCESSORIES)/SideClipBackStandard.stl \
    $(DESTACCESSORIES)/SideClipsAirVent.stl \
    $(DESTACCESSORIES)/MountingScrew25mm.stl \
    $(DESTACCESSORIES)/MountingScrew40mm.stl

plates: baseplates mountplates equipmentplates

baseplates: \
    $(DESTPLATES)/VentedPlate.stl \
    $(DESTPLATES)/DrawerStandard.stl \
    $(DESTPLATES)/DrawerSlim.stl \
    $(DESTPLATES)/8KeystonesStandard.stl \
    $(DESTPLATES)/8KeystonesSlim.stl \
    $(DESTPLATES)/12KeystonesStandard.stl \
    $(DESTPLATES)/12KeystonesSlim.stl \
    $(DESTPLATES)/SolidFullPlate.stl \
    $(DESTPLATES)/SolidHalfPlate.stl \
    $(DESTPLATES)/SolidQuarterPlate.stl

mountplates: \
    $(DESTPLATES)/UniversalSideScrews120mmStandard.stl \
    $(DESTPLATES)/UniversalSideScrews145mmStandard.stl \
    $(DESTPLATES)/UniversalSideScrews170mmStandard.stl \
    $(DESTPLATES)/UniversalSideScrews120mmSlim.stl \
    $(DESTPLATES)/UniversalSideScrews145mmSlim.stl \
    $(DESTPLATES)/UniversalSideScrews170mmSlim.stl \
    $(DESTPLATES)/UniversalBackScrews180mm-2Standard.stl \
    $(DESTPLATES)/UniversalBackScrews180mm-2Slim.stl \
    $(DESTPLATES)/UniversalBackScrewsWide-2Standard.stl \
    $(DESTPLATES)/UniversalBackScrewsWide-2Slim.stl

equipmentplates: \
    $(DESTEQUIPMENTPLATES)/HPElitedeskMiniStandardPlate.stl \
    $(DESTEQUIPMENTPLATES)/YuLinca8PortSlimPlate.stl \
    $(DESTEQUIPMENTPLATES)/TPLinkTLSG1008DPlate.stl \
    $(DESTEQUIPMENTPLATES)/NetgearGS208Plate.stl

clean:
	mkdir -p $(DESTSHELVES)
	rm -f $(DESTSHELVES)/*
	mkdir -p $(DESTACCESSORIES)
	rm -f $(DESTACCESSORIES)/*
	mkdir -p $(DESTPLATES)
	rm -f $(DESTPLATES)/*
	mkdir -p $(DESTEQUIPMENTPLATES)
	rm -f $(DESTEQUIPMENTPLATES)/*

