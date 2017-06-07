module Coligny
    def preprocess
        metonic_notations = {}
        metonic_resource = File.open(File.dirname(__FILE__) + '/resources/metonic_notations.txt')

        metonic_resource.readlines.each do |line|
            ary = line.split(",")
            metonic_notations[ary[0]] = []
            key = ary.shift
            ary.each do |notation|
                metonic_notations[key] << notation
            end
        end
    end
end