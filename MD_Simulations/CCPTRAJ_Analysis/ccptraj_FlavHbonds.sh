for i in *MD.nc;
do
echo $i
echo "parm S3L3_id113.prmtop" >> ${i}_cpptraj10.in
echo "trajin $i" >> ${i}_cpptraj10.in
echo "autoimage" >> ${i}_cpptraj10.in
echo "rms ToFirst :1-112&!@H= first out ${i}_rmsd.dat mass" >> ${i}_cpptraj10.in
echo "rmsd ca_all @CA out ${i}_rmsd_Ca.dat first" >> ${i}_cpptraj10.in
echo "atomicfluct out ${i}_rmsf.dat @C,CA,N byres" >> ${i}_cpptraj10.in
echo "rmsd FMN :FMN out ${i}_rmsd_RBF.dat first" >> ${i}_cpptraj10.in
echo "rmsd HEB :HEB out ${i}_rmsd_HEB.dat first" >> ${i}_cpptraj10.in
echo "nativecontacts :FMN@N1,C2,N3,C4,C4A,N5,C5A,C6,C7,C8,C9,C9A,N10,C10 :HEB@C3C,C2C,C1C,CHC,C4B,C3B,C2B,C1B,CHB,C4A,C3A,C2A,C1A,CHA,C4D,C3D,C2D,C1D,CHD,C4C mindist out ${i}_distance.csv" >> ${i}_cpptraj10.in
#
echo "hbond donormask :FMN acceptormask :1-112 out ${i}_nhb_protein.dat avgout ${i}_avghb_protein1.dat" >> ${i}_cpptraj10.in
echo "hbond donormask :1-112 acceptormask :FMN out ${i}_nhb2_protein.dat avgout ${i}_avghb_protein2.dat" >> ${i}_cpptraj10.in
#
echo "hbond donormask :FMN acceptormask :WAT@O out ${i}_nhb_solvent1.dat avgout ${i}_avghb_solvent1.dat" >> ${i}_cpptraj10.in
echo "hbond donormask :WAT acceptormask :FMN out ${i}_nhb_solvent2.dat avgout ${i}_avghb_solvent2.dat" >> ${i}_cpptraj10.in
#
#
echo "run" >> ${i}_cpptraj10.in
done
