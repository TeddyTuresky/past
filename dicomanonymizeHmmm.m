function y = dicomanonymize(x)
% for questions, please contact theodore.turesky@childrens.harvard.edu

    [p,n,e] = fileparts(x); % below gives output .dcm extensions
    y = dicomread(x);
    dcm = dicominfo(x);
    
    % changing the following attributes to 'anonymize' (list taken from
    % Mango software)
    dcm.InstitutionName = 'anon';
    dcm.InstitutionAddress = 'anon';
    dcm.ReferringPhysicianName = 'anon';
    dcm.PatientName = 'anon';
    dcm.PatientID = 'anon';
    dcm.PatientBirthDate = 'anon';
    dcm.PatientAge = 'anon'; % also
    
    dicomwrite(y,[p '/df-' n '.dcm'],dcm,'WritePrivate',1);
    
    
end
    
    