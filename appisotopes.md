<a name="sec:isotopes"></a>
# Isotope List

The table listed in this Appendix is generated with the following
code, listing all six properties of CDK atom types, as outlined
in Section [12.1](atomtype.md#sec:cdkatomtype). Abundances and exact masses are
inherited from the BODR project, which contains
values extracted from IUPAC recommendations.

**<a name="script:ListAllIsotopes">Script 22.1</a>** [code/ListAllIsotopes.groovy](code/ListAllIsotopes.code.md)
```groovy
isofac = Isotopes.getInstance();
maxAtomicNumber = 150;
for (atomicNumber in 1..maxAtomicNumber) {
  element = isofac.getElement(atomicNumber)
  isotopes = isofac.getIsotopes(element.symbol)
  for (isotope in isotopes) {
    if (isotope.naturalAbundance > 0.1) {
      output.append(
        "<td>" +
          atomicNumber + "</td><td>" +
          element.symbol +
        "</td>"
      )
      output.append(
        "<td>" +
        isotope.massNumber + "</td><td>" +
        isotope.naturalAbundance + "</td><td>" +
        isotope.exactMass +
        "</td>"
      )
    }
  }
}
```

The full version of the above script lists all (natural) isotopes
with an abundance of more than 0.1:

<table>
<tr>
<td><b>atomic number</b></td>
<td><b>element symbol</b></td>
<td><b>mass number</b></td>
<td><b>abundance</b></td>
<td><b>exact mass</b></td>
</tr>
<tr><td>1</td><td>H</td><td>1</td><td>99.9885</td><td>1.007825032</td></tr>
<tr><td>2</td><td>He</td><td>4</td><td>99.999863</td><td>4.002603254</td></tr>
<tr><td>3</td><td>Li</td><td>6</td><td>7.59</td><td>6.015122795</td></tr>
<tr><td></td><td></td><td>7</td><td>92.41</td><td>7.01600455</td></tr>
<tr><td>4</td><td>Be</td><td>9</td><td>100.0</td><td>9.0121822</td></tr>
<tr><td>5</td><td>B</td><td>10</td><td>19.9</td><td>10.012937</td></tr>
<tr><td></td><td></td><td>11</td><td>80.1</td><td>11.0093054</td></tr>
<tr><td>6</td><td>C</td><td>12</td><td>98.93</td><td>12.0</td></tr>
<tr><td></td><td></td><td>13</td><td>1.07</td><td>13.00335484</td></tr>
<tr><td>7</td><td>N</td><td>14</td><td>99.636</td><td>14.003074</td></tr>
<tr><td></td><td></td><td>15</td><td>0.364</td><td>15.0001089</td></tr>
<tr><td>8</td><td>O</td><td>16</td><td>99.757</td><td>15.99491462</td></tr>
<tr><td></td><td></td><td>18</td><td>0.205</td><td>17.999161</td></tr>
<tr><td>9</td><td>F</td><td>19</td><td>100.0</td><td>18.99840322</td></tr>
<tr><td>10</td><td>Ne</td><td>20</td><td>90.48</td><td>19.99244018</td></tr>
<tr><td></td><td></td><td>21</td><td>0.27</td><td>20.99384668</td></tr>
<tr><td></td><td></td><td>22</td><td>9.25</td><td>21.99138511</td></tr>
<tr><td>11</td><td>Na</td><td>23</td><td>100.0</td><td>22.98976928</td></tr>
<tr><td>12</td><td>Mg</td><td>24</td><td>78.99</td><td>23.9850417</td></tr>
<tr><td></td><td></td><td>25</td><td>10.0</td><td>24.98583692</td></tr>
<tr><td></td><td></td><td>26</td><td>11.01</td><td>25.98259293</td></tr>
<tr><td>13</td><td>Al</td><td>27</td><td>100.0</td><td>26.98153863</td></tr>
<tr><td>14</td><td>Si</td><td>28</td><td>92.2297</td><td>27.97692653</td></tr>
<tr><td></td><td></td><td>29</td><td>4.6832</td><td>28.9764947</td></tr>
<tr><td></td><td></td><td>30</td><td>3.0872</td><td>29.97377017</td></tr>
<tr><td>15</td><td>P</td><td>31</td><td>100.0</td><td>30.97376163</td></tr>
<tr><td>16</td><td>S</td><td>32</td><td>94.93</td><td>31.972071</td></tr>
<tr><td></td><td></td><td>33</td><td>0.76</td><td>32.97145876</td></tr>
<tr><td></td><td></td><td>34</td><td>4.29</td><td>33.9678669</td></tr>
<tr><td>17</td><td>Cl</td><td>35</td><td>75.76</td><td>34.96885268</td></tr>
<tr><td></td><td></td><td>37</td><td>24.24</td><td>36.96590259</td></tr>
<tr><td>18</td><td>Ar</td><td>36</td><td>0.3365</td><td>35.96754511</td></tr>
<tr><td></td><td></td><td>40</td><td>99.6003</td><td>39.96238312</td></tr>
<tr><td>19</td><td>K</td><td>39</td><td>93.2581</td><td>38.96370668</td></tr>
<tr><td></td><td></td><td>41</td><td>6.7302</td><td>40.96182576</td></tr>
<tr><td>20</td><td>Ca</td><td>40</td><td>96.941</td><td>39.96259098</td></tr>
<tr><td></td><td></td><td>42</td><td>0.647</td><td>41.95861801</td></tr>
<tr><td></td><td></td><td>43</td><td>0.135</td><td>42.9587666</td></tr>
<tr><td></td><td></td><td>44</td><td>2.086</td><td>43.9554818</td></tr>
<tr><td></td><td></td><td>48</td><td>0.187</td><td>47.952534</td></tr>
<tr><td>21</td><td>Sc</td><td>45</td><td>100.0</td><td>44.9559119</td></tr>
<tr><td>22</td><td>Ti</td><td>46</td><td>8.25</td><td>45.9526316</td></tr>
<tr><td></td><td></td><td>47</td><td>7.44</td><td>46.9517631</td></tr>
<tr><td></td><td></td><td>48</td><td>73.72</td><td>47.9479463</td></tr>
<tr><td></td><td></td><td>49</td><td>5.41</td><td>48.94787</td></tr>
<tr><td></td><td></td><td>50</td><td>5.18</td><td>49.9447912</td></tr>
<tr><td>23</td><td>V</td><td>50</td><td>0.25</td><td>49.9471585</td></tr>
<tr><td></td><td></td><td>51</td><td>99.75</td><td>50.9439595</td></tr>
<tr><td>24</td><td>Cr</td><td>50</td><td>4.345</td><td>49.9460442</td></tr>
<tr><td></td><td></td><td>52</td><td>83.789</td><td>51.9405075</td></tr>
<tr><td></td><td></td><td>53</td><td>9.501</td><td>52.9406494</td></tr>
<tr><td></td><td></td><td>54</td><td>2.365</td><td>53.9388804</td></tr>
<tr><td>25</td><td>Mn</td><td>55</td><td>100.0</td><td>54.9380451</td></tr>
<tr><td>26</td><td>Fe</td><td>54</td><td>5.845</td><td>53.9396105</td></tr>
<tr><td></td><td></td><td>56</td><td>91.754</td><td>55.9349375</td></tr>
<tr><td></td><td></td><td>57</td><td>2.119</td><td>56.935394</td></tr>
<tr><td></td><td></td><td>58</td><td>0.282</td><td>57.9332756</td></tr>
<tr><td>27</td><td>Co</td><td>59</td><td>100.0</td><td>58.933195</td></tr>
<tr><td>28</td><td>Ni</td><td>58</td><td>68.0769</td><td>57.9353429</td></tr>
<tr><td></td><td></td><td>60</td><td>26.2231</td><td>59.9307864</td></tr>
<tr><td></td><td></td><td>61</td><td>1.1399</td><td>60.931056</td></tr>
<tr><td></td><td></td><td>62</td><td>3.6345</td><td>61.9283451</td></tr>
<tr><td></td><td></td><td>64</td><td>0.9256</td><td>63.927966</td></tr>
<tr><td>29</td><td>Cu</td><td>63</td><td>69.17</td><td>62.9295975</td></tr>
<tr><td></td><td></td><td>65</td><td>30.83</td><td>64.9277895</td></tr>
<tr><td>30</td><td>Zn</td><td>64</td><td>48.63</td><td>63.9291422</td></tr>
<tr><td></td><td></td><td>66</td><td>27.9</td><td>65.9260334</td></tr>
<tr><td></td><td></td><td>67</td><td>4.1</td><td>66.9271273</td></tr>
<tr><td></td><td></td><td>68</td><td>18.75</td><td>67.9248442</td></tr>
<tr><td></td><td></td><td>70</td><td>0.62</td><td>69.9253193</td></tr>
<tr><td>31</td><td>Ga</td><td>69</td><td>60.108</td><td>68.9255736</td></tr>
<tr><td></td><td></td><td>71</td><td>39.892</td><td>70.9247013</td></tr>
<tr><td>32</td><td>Ge</td><td>70</td><td>20.84</td><td>69.9242474</td></tr>
<tr><td></td><td></td><td>72</td><td>27.54</td><td>71.9220758</td></tr>
<tr><td></td><td></td><td>73</td><td>7.73</td><td>72.9234589</td></tr>
<tr><td></td><td></td><td>74</td><td>36.28</td><td>73.9211778</td></tr>
<tr><td></td><td></td><td>76</td><td>7.61</td><td>75.9214026</td></tr>
<tr><td>33</td><td>As</td><td>75</td><td>100.0</td><td>74.9215965</td></tr>
<tr><td>34</td><td>Se</td><td>74</td><td>0.89</td><td>73.9224764</td></tr>
<tr><td></td><td></td><td>76</td><td>9.37</td><td>75.9192136</td></tr>
<tr><td></td><td></td><td>77</td><td>7.63</td><td>76.919914</td></tr>
<tr><td></td><td></td><td>78</td><td>23.77</td><td>77.9173091</td></tr>
<tr><td></td><td></td><td>80</td><td>49.61</td><td>79.9165213</td></tr>
<tr><td></td><td></td><td>82</td><td>8.73</td><td>81.9166994</td></tr>
<tr><td>35</td><td>Br</td><td>79</td><td>50.69</td><td>78.9183371</td></tr>
<tr><td></td><td></td><td>81</td><td>49.31</td><td>80.9162906</td></tr>
<tr><td>36</td><td>Kr</td><td>78</td><td>0.35</td><td>77.9203648</td></tr>
<tr><td></td><td></td><td>80</td><td>2.28</td><td>79.916379</td></tr>
<tr><td></td><td></td><td>82</td><td>11.58</td><td>81.9134836</td></tr>
<tr><td></td><td></td><td>83</td><td>11.49</td><td>82.914136</td></tr>
<tr><td></td><td></td><td>84</td><td>57.0</td><td>83.911507</td></tr>
<tr><td></td><td></td><td>86</td><td>17.3</td><td>85.91061073</td></tr>
<tr><td>37</td><td>Rb</td><td>85</td><td>72.17</td><td>84.91178974</td></tr>
<tr><td></td><td></td><td>87</td><td>27.83</td><td>86.90918053</td></tr>
<tr><td>38</td><td>Sr</td><td>84</td><td>0.56</td><td>83.913425</td></tr>
<tr><td></td><td></td><td>86</td><td>9.86</td><td>85.9092602</td></tr>
<tr><td></td><td></td><td>87</td><td>7.0</td><td>86.9088771</td></tr>
<tr><td></td><td></td><td>88</td><td>82.58</td><td>87.9056121</td></tr>
<tr><td>39</td><td>Y</td><td>89</td><td>100.0</td><td>88.9058483</td></tr>
<tr><td>40</td><td>Zr</td><td>90</td><td>51.45</td><td>89.9047044</td></tr>
<tr><td></td><td></td><td>91</td><td>11.22</td><td>90.9056458</td></tr>
<tr><td></td><td></td><td>92</td><td>17.15</td><td>91.9050408</td></tr>
<tr><td></td><td></td><td>94</td><td>17.38</td><td>93.9063152</td></tr>
<tr><td></td><td></td><td>96</td><td>2.8</td><td>95.9082734</td></tr>
<tr><td>41</td><td>Nb</td><td>93</td><td>100.0</td><td>92.9063781</td></tr>
<tr><td>42</td><td>Mo</td><td>92</td><td>14.84</td><td>91.906811</td></tr>
<tr><td></td><td></td><td>94</td><td>9.25</td><td>93.9050883</td></tr>
<tr><td></td><td></td><td>95</td><td>15.92</td><td>94.9058421</td></tr>
<tr><td></td><td></td><td>96</td><td>16.68</td><td>95.9046795</td></tr>
<tr><td></td><td></td><td>97</td><td>9.55</td><td>96.9060215</td></tr>
<tr><td></td><td></td><td>98</td><td>24.13</td><td>97.9054082</td></tr>
<tr><td></td><td></td><td>100</td><td>9.63</td><td>99.907477</td></tr>
<tr><td>44</td><td>Ru</td><td>96</td><td>5.54</td><td>95.907598</td></tr>
<tr><td></td><td></td><td>98</td><td>1.87</td><td>97.905287</td></tr>
<tr><td></td><td></td><td>99</td><td>12.76</td><td>98.9059393</td></tr>
<tr><td></td><td></td><td>100</td><td>12.6</td><td>99.9042195</td></tr>
<tr><td></td><td></td><td>101</td><td>17.06</td><td>100.9055821</td></tr>
<tr><td></td><td></td><td>102</td><td>31.55</td><td>101.9043493</td></tr>
<tr><td></td><td></td><td>104</td><td>18.62</td><td>103.905433</td></tr>
<tr><td>45</td><td>Rh</td><td>103</td><td>100.0</td><td>102.905504</td></tr>
<tr><td>46</td><td>Pd</td><td>102</td><td>1.02</td><td>101.905609</td></tr>
<tr><td></td><td></td><td>104</td><td>11.14</td><td>103.904036</td></tr>
<tr><td></td><td></td><td>105</td><td>22.33</td><td>104.905085</td></tr>
<tr><td></td><td></td><td>106</td><td>27.33</td><td>105.903486</td></tr>
<tr><td></td><td></td><td>108</td><td>26.46</td><td>107.903892</td></tr>
<tr><td></td><td></td><td>110</td><td>11.72</td><td>109.905153</td></tr>
<tr><td>47</td><td>Ag</td><td>107</td><td>51.839</td><td>106.905097</td></tr>
<tr><td></td><td></td><td>109</td><td>48.161</td><td>108.904752</td></tr>
<tr><td>48</td><td>Cd</td><td>106</td><td>1.25</td><td>105.906459</td></tr>
<tr><td></td><td></td><td>108</td><td>0.89</td><td>107.904184</td></tr>
<tr><td></td><td></td><td>110</td><td>12.49</td><td>109.9030021</td></tr>
<tr><td></td><td></td><td>111</td><td>12.8</td><td>110.9041781</td></tr>
<tr><td></td><td></td><td>112</td><td>24.13</td><td>111.9027578</td></tr>
<tr><td></td><td></td><td>113</td><td>12.22</td><td>112.9044017</td></tr>
<tr><td></td><td></td><td>114</td><td>28.73</td><td>113.9033585</td></tr>
<tr><td></td><td></td><td>116</td><td>7.49</td><td>115.904756</td></tr>
<tr><td>49</td><td>In</td><td>113</td><td>4.29</td><td>112.904058</td></tr>
<tr><td></td><td></td><td>115</td><td>95.71</td><td>114.903878</td></tr>
<tr><td>50</td><td>Sn</td><td>112</td><td>0.97</td><td>111.904818</td></tr>
<tr><td></td><td></td><td>114</td><td>0.66</td><td>113.902779</td></tr>
<tr><td></td><td></td><td>115</td><td>0.34</td><td>114.903342</td></tr>
<tr><td></td><td></td><td>116</td><td>14.54</td><td>115.901741</td></tr>
<tr><td></td><td></td><td>117</td><td>7.68</td><td>116.902952</td></tr>
<tr><td></td><td></td><td>118</td><td>24.22</td><td>117.901603</td></tr>
<tr><td></td><td></td><td>119</td><td>8.59</td><td>118.903308</td></tr>
<tr><td></td><td></td><td>120</td><td>32.58</td><td>119.9021947</td></tr>
<tr><td></td><td></td><td>122</td><td>4.63</td><td>121.903439</td></tr>
<tr><td></td><td></td><td>124</td><td>5.79</td><td>123.9052739</td></tr>
<tr><td>51</td><td>Sb</td><td>121</td><td>57.21</td><td>120.9038157</td></tr>
<tr><td></td><td></td><td>123</td><td>42.79</td><td>122.904214</td></tr>
<tr><td>52</td><td>Te</td><td>122</td><td>2.55</td><td>121.9030439</td></tr>
<tr><td></td><td></td><td>123</td><td>0.89</td><td>122.90427</td></tr>
<tr><td></td><td></td><td>124</td><td>4.74</td><td>123.9028179</td></tr>
<tr><td></td><td></td><td>125</td><td>7.07</td><td>124.9044307</td></tr>
<tr><td></td><td></td><td>126</td><td>18.84</td><td>125.9033117</td></tr>
<tr><td></td><td></td><td>128</td><td>31.74</td><td>127.9044631</td></tr>
<tr><td></td><td></td><td>130</td><td>34.08</td><td>129.9062244</td></tr>
<tr><td>53</td><td>I</td><td>127</td><td>100.0</td><td>126.904473</td></tr>
<tr><td>54</td><td>Xe</td><td>128</td><td>1.92</td><td>127.9035313</td></tr>
<tr><td></td><td></td><td>129</td><td>26.44</td><td>128.9047794</td></tr>
<tr><td></td><td></td><td>130</td><td>4.08</td><td>129.903508</td></tr>
<tr><td></td><td></td><td>131</td><td>21.18</td><td>130.9050824</td></tr>
<tr><td></td><td></td><td>132</td><td>26.89</td><td>131.9041535</td></tr>
<tr><td></td><td></td><td>134</td><td>10.44</td><td>133.9053945</td></tr>
<tr><td></td><td></td><td>136</td><td>8.87</td><td>135.907219</td></tr>
<tr><td>55</td><td>Cs</td><td>133</td><td>100.0</td><td>132.9054519</td></tr>
<tr><td>56</td><td>Ba</td><td>130</td><td>0.106</td><td>129.9063208</td></tr>
<tr><td></td><td></td><td>132</td><td>0.101</td><td>131.9050613</td></tr>
<tr><td></td><td></td><td>134</td><td>2.417</td><td>133.9045084</td></tr>
<tr><td></td><td></td><td>135</td><td>6.592</td><td>134.9056886</td></tr>
<tr><td></td><td></td><td>136</td><td>7.854</td><td>135.9045759</td></tr>
<tr><td></td><td></td><td>137</td><td>11.232</td><td>136.9058274</td></tr>
<tr><td></td><td></td><td>138</td><td>71.698</td><td>137.9052472</td></tr>
<tr><td>57</td><td>La</td><td>139</td><td>99.91</td><td>138.9063533</td></tr>
<tr><td>58</td><td>Ce</td><td>136</td><td>0.185</td><td>135.907172</td></tr>
<tr><td></td><td></td><td>138</td><td>0.251</td><td>137.905991</td></tr>
<tr><td></td><td></td><td>140</td><td>88.45</td><td>139.9054387</td></tr>
<tr><td></td><td></td><td>142</td><td>11.114</td><td>141.909244</td></tr>
<tr><td>59</td><td>Pr</td><td>141</td><td>100.0</td><td>140.9076528</td></tr>
<tr><td>60</td><td>Nd</td><td>142</td><td>27.2</td><td>141.9077233</td></tr>
<tr><td></td><td></td><td>143</td><td>12.2</td><td>142.9098143</td></tr>
<tr><td></td><td></td><td>144</td><td>23.8</td><td>143.9100873</td></tr>
<tr><td></td><td></td><td>145</td><td>8.3</td><td>144.9125736</td></tr>
<tr><td></td><td></td><td>146</td><td>17.2</td><td>145.9131169</td></tr>
<tr><td></td><td></td><td>148</td><td>5.7</td><td>147.916893</td></tr>
<tr><td></td><td></td><td>150</td><td>5.6</td><td>149.920891</td></tr>
<tr><td>62</td><td>Sm</td><td>144</td><td>3.07</td><td>143.911999</td></tr>
<tr><td></td><td></td><td>147</td><td>14.99</td><td>146.9148979</td></tr>
<tr><td></td><td></td><td>148</td><td>11.24</td><td>147.9148227</td></tr>
<tr><td></td><td></td><td>149</td><td>13.82</td><td>148.9171847</td></tr>
<tr><td></td><td></td><td>150</td><td>7.38</td><td>149.9172755</td></tr>
<tr><td></td><td></td><td>152</td><td>26.75</td><td>151.9197324</td></tr>
<tr><td></td><td></td><td>154</td><td>22.75</td><td>153.9222093</td></tr>
<tr><td>63</td><td>Eu</td><td>151</td><td>47.81</td><td>150.9198502</td></tr>
<tr><td></td><td></td><td>153</td><td>52.19</td><td>152.9212303</td></tr>
<tr><td>64</td><td>Gd</td><td>152</td><td>0.2</td><td>151.919791</td></tr>
<tr><td></td><td></td><td>154</td><td>2.18</td><td>153.9208656</td></tr>
<tr><td></td><td></td><td>155</td><td>14.8</td><td>154.922622</td></tr>
<tr><td></td><td></td><td>156</td><td>20.47</td><td>155.9221227</td></tr>
<tr><td></td><td></td><td>157</td><td>15.65</td><td>156.9239601</td></tr>
<tr><td></td><td></td><td>158</td><td>24.84</td><td>157.9241039</td></tr>
<tr><td></td><td></td><td>160</td><td>21.86</td><td>159.9270541</td></tr>
<tr><td>65</td><td>Tb</td><td>159</td><td>100.0</td><td>158.9253468</td></tr>
<tr><td>66</td><td>Dy</td><td>160</td><td>2.34</td><td>159.9251975</td></tr>
<tr><td></td><td></td><td>161</td><td>18.91</td><td>160.9269334</td></tr>
<tr><td></td><td></td><td>162</td><td>25.51</td><td>161.9267984</td></tr>
<tr><td></td><td></td><td>163</td><td>24.9</td><td>162.9287312</td></tr>
<tr><td></td><td></td><td>164</td><td>28.18</td><td>163.9291748</td></tr>
<tr><td>67</td><td>Ho</td><td>165</td><td>100.0</td><td>164.9303221</td></tr>
<tr><td>68</td><td>Er</td><td>162</td><td>0.14</td><td>161.928778</td></tr>
<tr><td></td><td></td><td>164</td><td>1.61</td><td>163.9292</td></tr>
<tr><td></td><td></td><td>166</td><td>33.61</td><td>165.9302931</td></tr>
<tr><td></td><td></td><td>167</td><td>22.93</td><td>166.9320482</td></tr>
<tr><td></td><td></td><td>168</td><td>26.78</td><td>167.9323702</td></tr>
<tr><td></td><td></td><td>170</td><td>14.93</td><td>169.9354643</td></tr>
<tr><td>69</td><td>Tm</td><td>169</td><td>100.0</td><td>168.9342133</td></tr>
<tr><td>70</td><td>Yb</td><td>168</td><td>0.13</td><td>167.933897</td></tr>
<tr><td></td><td></td><td>170</td><td>3.04</td><td>169.9347618</td></tr>
<tr><td></td><td></td><td>171</td><td>14.28</td><td>170.9363258</td></tr>
<tr><td></td><td></td><td>172</td><td>21.83</td><td>171.9363815</td></tr>
<tr><td></td><td></td><td>173</td><td>16.13</td><td>172.9382108</td></tr>
<tr><td></td><td></td><td>174</td><td>31.83</td><td>173.9388621</td></tr>
<tr><td></td><td></td><td>176</td><td>12.76</td><td>175.9425717</td></tr>
<tr><td>71</td><td>Lu</td><td>175</td><td>97.41</td><td>174.9407718</td></tr>
<tr><td></td><td></td><td>176</td><td>2.59</td><td>175.9426863</td></tr>
<tr><td>72</td><td>Hf</td><td>174</td><td>0.16</td><td>173.940046</td></tr>
<tr><td></td><td></td><td>176</td><td>5.26</td><td>175.9414086</td></tr>
<tr><td></td><td></td><td>177</td><td>18.6</td><td>176.9432207</td></tr>
<tr><td></td><td></td><td>178</td><td>27.28</td><td>177.9436988</td></tr>
<tr><td></td><td></td><td>179</td><td>13.62</td><td>178.9458161</td></tr>
<tr><td></td><td></td><td>180</td><td>35.08</td><td>179.94655</td></tr>
<tr><td>73</td><td>Ta</td><td>181</td><td>99.988</td><td>180.9479958</td></tr>
<tr><td>74</td><td>W</td><td>180</td><td>0.12</td><td>179.946704</td></tr>
<tr><td></td><td></td><td>182</td><td>26.5</td><td>181.9482042</td></tr>
<tr><td></td><td></td><td>183</td><td>14.31</td><td>182.950223</td></tr>
<tr><td></td><td></td><td>184</td><td>30.64</td><td>183.9509312</td></tr>
<tr><td></td><td></td><td>186</td><td>28.43</td><td>185.9543641</td></tr>
<tr><td>75</td><td>Re</td><td>185</td><td>37.4</td><td>184.952955</td></tr>
<tr><td></td><td></td><td>187</td><td>62.6</td><td>186.9557531</td></tr>
<tr><td>76</td><td>Os</td><td>186</td><td>1.59</td><td>185.9538382</td></tr>
<tr><td></td><td></td><td>187</td><td>1.96</td><td>186.9557505</td></tr>
<tr><td></td><td></td><td>188</td><td>13.24</td><td>187.9558382</td></tr>
<tr><td></td><td></td><td>189</td><td>16.15</td><td>188.9581475</td></tr>
<tr><td></td><td></td><td>190</td><td>26.26</td><td>189.958447</td></tr>
<tr><td></td><td></td><td>192</td><td>40.78</td><td>191.9614807</td></tr>
<tr><td>77</td><td>Ir</td><td>191</td><td>37.3</td><td>190.960594</td></tr>
<tr><td></td><td></td><td>193</td><td>62.7</td><td>192.9629264</td></tr>
<tr><td>78</td><td>Pt</td><td>192</td><td>0.782</td><td>191.961038</td></tr>
<tr><td></td><td></td><td>194</td><td>32.967</td><td>193.9626803</td></tr>
<tr><td></td><td></td><td>195</td><td>33.832</td><td>194.9647911</td></tr>
<tr><td></td><td></td><td>196</td><td>25.242</td><td>195.9649515</td></tr>
<tr><td></td><td></td><td>198</td><td>7.163</td><td>197.967893</td></tr>
<tr><td>79</td><td>Au</td><td>197</td><td>100.0</td><td>196.9665687</td></tr>
<tr><td>80</td><td>Hg</td><td>196</td><td>0.15</td><td>195.965833</td></tr>
<tr><td></td><td></td><td>198</td><td>9.97</td><td>197.966769</td></tr>
<tr><td></td><td></td><td>199</td><td>16.87</td><td>198.9682799</td></tr>
<tr><td></td><td></td><td>200</td><td>23.1</td><td>199.968326</td></tr>
<tr><td></td><td></td><td>201</td><td>13.18</td><td>200.9703023</td></tr>
<tr><td></td><td></td><td>202</td><td>29.86</td><td>201.970643</td></tr>
<tr><td></td><td></td><td>204</td><td>6.87</td><td>203.9734939</td></tr>
<tr><td>81</td><td>Tl</td><td>203</td><td>29.524</td><td>202.9723442</td></tr>
<tr><td></td><td></td><td>205</td><td>70.476</td><td>204.9744275</td></tr>
<tr><td>82</td><td>Pb</td><td>204</td><td>1.4</td><td>203.9730436</td></tr>
<tr><td></td><td></td><td>206</td><td>24.1</td><td>205.9744653</td></tr>
<tr><td></td><td></td><td>207</td><td>22.1</td><td>206.9758969</td></tr>
<tr><td></td><td></td><td>208</td><td>52.4</td><td>207.9766521</td></tr>
<tr><td>83</td><td>Bi</td><td>209</td><td>100.0</td><td>208.9803987</td></tr>
<tr><td>90</td><td>Th</td><td>232</td><td>100.0</td><td>232.0380553</td></tr>
<tr><td>91</td><td>Pa</td><td>231</td><td>100.0</td><td>231.035884</td></tr>
<tr><td>92</td><td>U</td><td>235</td><td>0.72</td><td>235.0439299</td></tr>
<tr><td></td><td></td><td>238</td><td>99.2745</td><td>238.0507882</td></tr>
</table>
