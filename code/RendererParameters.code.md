# RendererParameters.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.11')

import java.util.List;
import java.awt.*;
import java.awt.image.*;
import javax.imageio.*;
import org.openscience.cdk.*;
import org.openscience.cdk.interfaces.*;
import org.openscience.cdk.layout.*;
import org.openscience.cdk.renderer.*;
import org.openscience.cdk.renderer.font.*;
import org.openscience.cdk.renderer.generators.*;
import org.openscience.cdk.renderer.generators.standard.StandardGenerator;
import org.openscience.cdk.renderer.visitor.*;
import org.openscience.cdk.templates.*;




IAtomContainer triazole = MoleculeFactory.make123Triazole();
StructureDiagramGenerator sdg = new StructureDiagramGenerator();
sdg.setMolecule(triazole);
sdg.generateCoordinates();
triazole = sdg.getMolecule();
// generators make the image elements
List<IGenerator> generators =
  new ArrayList<IGenerator>();
font = new Font(Font.SANS_SERIF, Font.PLAIN, 13)
generators.add(new BasicSceneGenerator());
generators.add(new StandardGenerator(font));
// the renderer needs to have a toolkit-specific font manager
AtomContainerRenderer renderer =
  new AtomContainerRenderer(generators, new AWTFontManager());
// dump all parameters
for (generator in renderer.generators) {
  for (parameter in generator.parameters) {
    println "parameter: " +
      parameter.class.name.substring(40) +
      " -> " +
      parameter.value;
  }
}
```
**Output:**
```plain
parameter: BasicSceneGenerator$BackgroundColor -> java.awt.Color[r=255,g=255,b...
  =255]
parameter: BasicSceneGenerator$ForegroundColor -> java.awt.Color[r=0,g=0,b=0]
parameter: BasicSceneGenerator$Margin -> 10.0
parameter: BasicSceneGenerator$UseAntiAliasing -> true
parameter: BasicSceneGenerator$UsedFontStyle -> NORMAL
parameter: BasicSceneGenerator$FontName -> Arial
parameter: BasicSceneGenerator$ZoomFactor -> 1.0
parameter: BasicSceneGenerator$Scale -> 1.0
parameter: BasicSceneGenerator$BondLength -> 40.0
parameter: BasicSceneGenerator$FitToScreen -> false
parameter: BasicSceneGenerator$ShowMoleculeTitle -> false
parameter: BasicSceneGenerator$ShowTooltip -> false
parameter: BasicSceneGenerator$ArrowHeadWidth -> 10.0
parameter: BasicSceneGenerator$ShowReactionTitle -> false
parameter: standard.StandardGenerator$AtomColor -> org.openscience.cdk.rendere...
  r.color.UniColor@55b62db8
parameter: standard.StandardGenerator$Visibility -> org.openscience.cdk.render...
  er.generators.standard.SelectionVisibility@e5c5e6
parameter: standard.StandardGenerator$StrokeRatio -> 1.0
parameter: standard.StandardGenerator$BondSeparation -> 0.16
parameter: standard.StandardGenerator$WedgeRatio -> 6.0
parameter: standard.StandardGenerator$SymbolMarginRatio -> 2.0
parameter: standard.StandardGenerator$HashSpacing -> 5.0
parameter: standard.StandardGenerator$DashSection -> 8
parameter: standard.StandardGenerator$WaveSpacing -> 5.0
parameter: standard.StandardGenerator$FancyBoldWedges -> true
parameter: standard.StandardGenerator$FancyHashedWedges -> true
parameter: standard.StandardGenerator$Highlighting -> Colored
parameter: standard.StandardGenerator$OuterGlowWidth -> 2.0
parameter: standard.StandardGenerator$AnnotationColor -> java.awt.Color[r=255,...
  g=0,b=0]
parameter: standard.StandardGenerator$AnnotationDistance -> 0.25
parameter: standard.StandardGenerator$AnnotationFontScale -> 0.5
parameter: standard.StandardGenerator$SgroupBracketDepth -> 0.18
parameter: standard.StandardGenerator$SgroupFontScale -> 0.6
parameter: standard.StandardGenerator$OmitMajorIsotopes -> false
parameter: standard.StandardGenerator$ForceDelocalisedBondDisplay -> false
parameter: standard.StandardGenerator$DelocalisedDonutsBondDisplay -> true
parameter: standard.StandardGenerator$DeuteriumSymbol -> true
parameter: standard.StandardGenerator$PseudoFontStyle -> 3
```
