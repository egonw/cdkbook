<a name="sec:moldescs"></a>
# Descriptors

The below tables lists several descriptor types available in the CDK.
The following code is for molecular descriptors, but equivalent code
is used for the other descriptor types:

**Script** [code/ListAllMolecularDescriptors.groovy](code/ListAllMolecularDescriptors.code.md)
```groovy
DescriptorEngine engine =
  new DescriptorEngine(
    descriptorClasses,
    DefaultChemObjectBuilder.getInstance()
  );
List<IDescriptor> instances =
  engine.getDescriptorInstances()
instances.sort{ it.specification.implementationTitle }
println "Descriptor count: " + instances.size()
for (IDescriptor descriptor : instances) {
  specification = descriptor.specification
  implementationTitle = specification.implementationTitle
  output.append(
    "<tr><td>" + implementationTitle + "</td><td>"
  )
  descriptor.descriptorNames.each { name ->
    output.append(name + " ")
  }
  output.append("</td></tr>\n")
}
```

<a name="sec:moldescs:mol"></a>
## Molecular Descriptors

<table>
<tr>
  <td>Class</td>
  <td>Descriptors</td>
<tr>
<tr><td>ALOGPDescriptor</td><td>ALogP ALogp2 AMR </td></tr>
<tr><td>APolDescriptor</td><td>apol </td></tr>
<tr><td>AcidicGroupCountDescriptor</td><td>nAcid </td></tr>
<tr><td>AminoAcidCountDescriptor</td><td>nA nR nN nD nC nF nQ nE nG nH nI nP nL nK nM nS nT nY nV nW </td></tr>
<tr><td>AromaticAtomsCountDescriptor</td><td>naAromAtom </td></tr>
<tr><td>AromaticBondsCountDescriptor</td><td>nAromBond </td></tr>
<tr><td>AtomCountDescriptor</td><td>nAtom </td></tr>
<tr><td>AutocorrelationDescriptorCharge</td><td>ATSc1 ATSc2 ATSc3 ATSc4 ATSc5 </td></tr>
<tr><td>AutocorrelationDescriptorMass</td><td>ATSm1 ATSm2 ATSm3 ATSm4 ATSm5 </td></tr>
<tr><td>AutocorrelationDescriptorPolarizability</td><td>ATSp1 ATSp2 ATSp3 ATSp4 ATSp5 </td></tr>
<tr><td>BCUTDescriptor</td><td>BCUTw-1l BCUTw-1h BCUTc-1l BCUTc-1h BCUTp-1l BCUTp-1h </td></tr>
<tr><td>BPolDescriptor</td><td>bpol </td></tr>
<tr><td>BasicGroupCountDescriptor</td><td>nBase </td></tr>
<tr><td>BondCountDescriptor</td><td>nB </td></tr>
<tr><td>CPSADescriptor</td><td>PPSA-1 PPSA-2 PPSA-3 PNSA-1 PNSA-2 PNSA-3 DPSA-1 DPSA-2 DPSA-3 FPSA-1 FPSA-2 FPSA-3 FNSA-1 FNSA-2 FNSA-3 WPSA-1 WPSA-2 WPSA-3 WNSA-1 WNSA-2 WNSA-3 RPCG RNCG RPCS RNCS THSA TPSA RHSA RPSA </td></tr>
<tr><td>CarbonTypesDescriptor</td><td>C1SP1 C2SP1 C1SP2 C2SP2 C3SP2 C1SP3 C2SP3 C3SP3 C4SP3 </td></tr>
<tr><td>ChiChainDescriptor</td><td>SCH-3 SCH-4 SCH-5 SCH-6 SCH-7 VCH-3 VCH-4 VCH-5 VCH-6 VCH-7 </td></tr>
<tr><td>ChiClusterDescriptor</td><td>SC-3 SC-4 SC-5 SC-6 VC-3 VC-4 VC-5 VC-6 </td></tr>
<tr><td>ChiPathClusterDescriptor</td><td>SPC-4 SPC-5 SPC-6 VPC-4 VPC-5 VPC-6 </td></tr>
<tr><td>ChiPathDescriptor</td><td>SP-0 SP-1 SP-2 SP-3 SP-4 SP-5 SP-6 SP-7 VP-0 VP-1 VP-2 VP-3 VP-4 VP-5 VP-6 VP-7 </td></tr>
<tr><td>EccentricConnectivityIndexDescriptor</td><td>ECCEN </td></tr>
<tr><td>FMFDescriptor</td><td>FMF </td></tr>
<tr><td>FragmentComplexityDescriptor</td><td>fragC </td></tr>
<tr><td>GravitationalIndexDescriptor</td><td>GRAV-1 GRAV-2 GRAV-3 GRAVH-1 GRAVH-2 GRAVH-3 GRAV-4 GRAV-5 GRAV-6 </td></tr>
<tr><td>HBondAcceptorCountDescriptor</td><td>nHBAcc </td></tr>
<tr><td>HBondDonorCountDescriptor</td><td>nHBDon </td></tr>
<tr><td>HybridizationRatioDescriptor</td><td>HybRatio </td></tr>
<tr><td>IPMolecularLearningDescriptor</td><td>MolIP </td></tr>
<tr><td>KappaShapeIndicesDescriptor</td><td>Kier1 Kier2 Kier3 </td></tr>
<tr><td>KierHallSmartsDescriptor</td><td>khs.sLi khs.ssBe khs.ssssBe khs.ssBH khs.sssB khs.ssssB khs.sCH3 khs.dCH2 khs.ssCH2 khs.tCH khs.dsCH khs.aaCH khs.sssCH khs.ddC khs.tsC khs.dssC khs.aasC khs.aaaC khs.ssssC khs.sNH3 khs.sNH2 khs.ssNH2 khs.dNH khs.ssNH khs.aaNH khs.tN khs.sssNH khs.dsN khs.aaN khs.sssN khs.ddsN khs.aasN khs.ssssN khs.sOH khs.dO khs.ssO khs.aaO khs.sF khs.sSiH3 khs.ssSiH2 khs.sssSiH khs.ssssSi khs.sPH2 khs.ssPH khs.sssP khs.dsssP khs.sssssP khs.sSH khs.dS khs.ssS khs.aaS khs.dssS khs.ddssS khs.sCl khs.sGeH3 khs.ssGeH2 khs.sssGeH khs.ssssGe khs.sAsH2 khs.ssAsH khs.sssAs khs.sssdAs khs.sssssAs khs.sSeH khs.dSe khs.ssSe khs.aaSe khs.dssSe khs.ddssSe khs.sBr khs.sSnH3 khs.ssSnH2 khs.sssSnH khs.ssssSn khs.sI khs.sPbH3 khs.ssPbH2 khs.sssPbH khs.ssssPb </td></tr>
<tr><td>LargestChainDescriptor</td><td>nAtomLC </td></tr>
<tr><td>LargestPiSystemDescriptor</td><td>nAtomP </td></tr>
<tr><td>LengthOverBreadthDescriptor</td><td>LOBMAX LOBMIN </td></tr>
<tr><td>LongestAliphaticChainDescriptor</td><td>nAtomLAC </td></tr>
<tr><td>MDEDescriptor</td><td>MDEC-11 MDEC-12 MDEC-13 MDEC-14 MDEC-22 MDEC-23 MDEC-24 MDEC-33 MDEC-34 MDEC-44 MDEO-11 MDEO-12 MDEO-22 MDEN-11 MDEN-12 MDEN-13 MDEN-22 MDEN-23 MDEN-33 </td></tr>
<tr><td>MannholdLogPDescriptor</td><td>MLogP </td></tr>
<tr><td>MomentOfInertiaDescriptor</td><td>MOMI-X MOMI-Y MOMI-Z MOMI-XY MOMI-XZ MOMI-YZ MOMI-R </td></tr>
<tr><td>PetitjeanNumberDescriptor</td><td>PetitjeanNumber </td></tr>
<tr><td>PetitjeanShapeIndexDescriptor</td><td>topoShape geomShape </td></tr>
<tr><td>RotatableBondsCountDescriptor</td><td>nRotB </td></tr>
<tr><td>RuleOfFiveDescriptor</td><td>LipinskiFailures </td></tr>
<tr><td>TPSADescriptor</td><td>TopoPSA </td></tr>
<tr><td>VABCDescriptor</td><td>VABC </td></tr>
<tr><td>VAdjMaDescriptor</td><td>VAdjMat </td></tr>
<tr><td>WHIMDescriptor</td><td>Wlambda1.unity Wlambda2.unity Wlambda3.unity Wnu1.unity Wnu2.unity Wgamma1.unity Wgamma2.unity Wgamma3.unity Weta1.unity Weta2.unity Weta3.unity WT.unity WA.unity WV.unity WK.unity WG.unity WD.unity </td></tr>
<tr><td>WeightDescriptor</td><td>MW </td></tr>
<tr><td>WeightedPathDescriptor</td><td>WTPT-1 WTPT-2 WTPT-3 WTPT-4 WTPT-5 </td></tr>
<tr><td>WienerNumbersDescriptor</td><td>WPATH WPOL </td></tr>
<tr><td>XLogPDescriptor</td><td>XLogP </td></tr>
<tr><td>ZagrebIndexDescriptor</td><td>Zagreb </td></tr>
</table>

<a name="sec:moldescs:mol"></a>
## Atomic Descriptors
<!-- <code>ListAllAtomicDescriptors</code> -->

<table>
<tr>
  <td>Class</td>
  <td>Descriptors</td>
<tr>
<tr><td>AtomDegreeDescriptor</td><td>aNeg </td></tr>
<tr><td>AtomHybridizationDescriptor</td><td>aHyb </td></tr>
<tr><td>AtomHybridizationVSEPRDescriptor</td><td>hybr </td></tr>
<tr><td>AtomValenceDescriptor</td><td>val </td></tr>
<tr><td>BondsToAtomDescriptor</td><td>bondsToAtom </td></tr>
<tr><td>CovalentRadiusDescriptor</td><td>covalentRadius </td></tr>
<tr><td>DistanceToAtomDescriptor</td><td>distanceToAtom </td></tr>
<tr><td>EffectiveAtomPolarizabilityDescriptor</td><td>effAtomPol </td></tr>
<tr><td>IPAtomicHOSEDescriptor</td><td>ipAtomicHOSE </td></tr>
<tr><td>IPAtomicLearningDescriptor</td><td>ipAtomicLearning </td></tr>
<tr><td>InductiveAtomicHardnessDescriptor</td><td>indAtomHardnesss </td></tr>
<tr><td>InductiveAtomicSoftnessDescriptor</td><td>indAtomSoftness </td></tr>
<tr><td>IsProtonInAromaticSystemDescriptor</td><td>protonInArmaticSystem </td></tr>
<tr><td>IsProtonInConjugatedPiSystemDescriptor</td><td>protonInConjSystem </td></tr>
<tr><td>PartialPiChargeDescriptor</td><td>pepe </td></tr>
<tr><td>PartialSigmaChargeDescriptor</td><td>partialSigmaCharge </td></tr>
<tr><td>PartialTChargeMMFF94Descriptor</td><td>partialTCMMFF94 </td></tr>
<tr><td>PartialTChargePEOEDescriptor</td><td>pepeT </td></tr>
<tr><td>PeriodicTablePositionDescriptor</td><td>periodicTablePosition </td></tr>
<tr><td>PiElectronegativityDescriptor</td><td>elecPiA </td></tr>
<tr><td>ProtonAffinityHOSEDescriptor</td><td>protonAffiHOSE </td></tr>
<tr><td>ProtonTotalPartialChargeDescriptor</td><td>protonTotalPartialCharge1 protonTotalPartialCharge2 protonTotalPartialCharge3 protonTotalPartialCharge4 protonTotalPartialCharge5 </td></tr>
<tr><td>RDFProtonDescriptor\_G3R</td><td>g3r\_1 g3r\_2 g3r\_3 g3r\_4 g3r\_5 g3r\_6 g3r\_7 g3r\_8 g3r\_9 g3r\_10 g3r\_11 g3r\_12 g3r\_13 </td></tr>
<tr><td>RDFProtonDescriptor\_GDR</td><td>gDr\_1 gDr\_2 gDr\_3 gDr\_4 gDr\_5 gDr\_6 gDr\_7 </td></tr>
<tr><td>RDFProtonDescriptor\_GHR</td><td>RDF\_GHR\_0 RDF\_GHR\_1 RDF\_GHR\_2 RDF\_GHR\_3 RDF\_GHR\_4 RDF\_GHR\_5 RDF\_GHR\_6 RDF\_GHR\_7 RDF\_GHR\_8 RDF\_GHR\_9 RDF\_GHR\_10 RDF\_GHR\_11 RDF\_GHR\_12 RDF\_GHR\_13 RDF\_GHR\_14 </td></tr>
<tr><td>RDFProtonDescriptor\_GHR\_topol</td><td>gHrTop\_1 gHrTop\_2 gHrTop\_3 gHrTop\_4 gHrTop\_5 gHrTop\_6 gHrTop\_7 gHrTop\_8 gHrTop\_9 gHrTop\_10 gHrTop\_11 gHrTop\_12 gHrTop\_13 gHrTop\_14 gHrTop\_15 </td></tr>
<tr><td>RDFProtonDescriptor\_GSR</td><td>gSr\_1 gSr\_2 gSr\_3 gSr\_4 gSr\_5 gSr\_6 gSr\_7 </td></tr>
<tr><td>SigmaElectronegativityDescriptor</td><td>elecSigmA </td></tr>
<tr><td>StabilizationPlusChargeDescriptor</td><td>stabilPlusC </td></tr>
<tr><td>VdWRadiusDescriptor</td><td>vdwRadius </td></tr>
</table>

<a name="sec:moldescs:mol"></a>
## Atom Pair Descriptors
<!-- <code>ListAllAtomPairDescriptors</code> -->

<table>
<tr>
  <td>Class</td>
  <td>Descriptors</td>
<tr>
<tr><td>PiContactDetectionDescriptor</td><td>piContact </td></tr>
</table>

<a name="sec:moldescs:mol"></a>
## Bond Descriptors
<!-- <code>ListAllBondDescriptors</code> -->

<table>
<tr>
  <td>Class</td>
  <td>Descriptors</td>
<tr>
<tr><td>AtomicNumberDifferenceDescriptor</td><td>MNDiff </td></tr>
<tr><td>BondPartialPiChargeDescriptor</td><td>pepeB </td></tr>
<tr><td>BondPartialSigmaChargeDescriptor</td><td>peoeB </td></tr>
<tr><td>BondPartialTChargeDescriptor</td><td>pCB </td></tr>
<tr><td>BondSigmaElectronegativityDescriptor</td><td>elecSigB </td></tr>
<tr><td>IPBondLearningDescriptor</td><td>ipBondLearning </td></tr>
</table>

<a name="sec:moldescs:mol"></a>
## Protein Descriptors
<!-- <code>ListAllProteinDescriptors</code> -->

<table>
<tr>
  <td>Class</td>
  <td>Descriptors</td>
<tr>
<tr><td>TaeAminoAcidDescriptor</td><td>TAE0 TAE1 TAE2 TAE3 TAE4 TAE5 TAE6 TAE7 TAE8 TAE9 TAE10 TAE11 TAE12 TAE13 TAE14 TAE15 TAE16 TAE17 TAE18 TAE19 TAE20 TAE21 TAE22 TAE23 TAE24 TAE25 TAE26 TAE27 TAE28 TAE29 TAE30 TAE31 TAE32 TAE33 TAE34 TAE35 TAE36 TAE37 TAE38 TAE39 TAE40 TAE41 TAE42 TAE43 TAE44 TAE45 TAE46 TAE47 TAE48 TAE49 TAE50 TAE51 TAE52 TAE53 TAE54 TAE55 TAE56 TAE57 TAE58 TAE59 TAE60 TAE61 TAE62 TAE63 TAE64 TAE65 TAE66 TAE67 TAE68 TAE69 TAE70 TAE71 TAE72 TAE73 TAE74 TAE75 TAE76 TAE77 TAE78 TAE79 TAE80 TAE81 TAE82 TAE83 TAE84 TAE85 TAE86 TAE87 TAE88 TAE89 TAE90 TAE91 TAE92 TAE93 TAE94 TAE95 TAE96 TAE97 TAE98 TAE99 TAE100 TAE101 TAE102 TAE103 TAE104 TAE105 TAE106 TAE107 TAE108 TAE109 TAE110 TAE111 TAE112 TAE113 TAE114 TAE115 TAE116 TAE117 TAE118 TAE119 TAE120 TAE121 TAE122 TAE123 TAE124 TAE125 TAE126 TAE127 TAE128 TAE129 TAE130 TAE131 TAE132 TAE133 TAE134 TAE135 TAE136 TAE137 TAE138 TAE139 TAE140 TAE141 TAE142 TAE143 TAE144 TAE145 TAE146 </td></tr>
</table>

